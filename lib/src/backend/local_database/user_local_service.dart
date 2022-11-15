import 'package:path/path.dart';
import 'package:simform_kaival/src/models/user_model.dart';
import 'package:simform_kaival/src/utils/constants/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserLocalService {
  UserLocalService._internal();

  static final _singleton = UserLocalService._internal();

  factory UserLocalService() => _singleton;

  static Database? db;
  String myTable = 'user_table';
  Future<Database> get database async {
    try {
      if (db != null) return db!;
      db = await initDatabase();
      logger.d("Created Database Successfully");
      return db!;
    } catch (err) {
      logger.e(err);
      throw Exception('Cannot create local database');
    }
  }

  Future<Database> initDatabase() async {
    final dPath = await getDatabasesPath();
    final path = join(dPath, 'local_user.db');

    //PRIMARY KEY
    String colId = 'id';
    //OTHER FIELDS
    String gender = 'gender';
    String name = 'name';
    String location = 'location';
    String email = 'email';
    String phone = 'phone';
    String uid = 'uid';
    String picture = 'picture';
    //DIDNT MAKE USE OF ALL THE FIELDS INSIDE USER MODEL AS TIME CONSTRAINTS ARE TIGHT SO DIDNT MADE ALL THE TABLES SEPERATELY
    //SURELY I COULD HAVE MAKE OTHER TABLES AND LINKED FOREIGN AND PRIMARY KEYS
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async => await db.execute('''
CREATE TABLE IF NOT EXISTS $myTable ( 
  $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $gender TEXT NOT NULL,
  $name TEXT NOT NULL,
  $location TEXT NOT NULL,
  $email TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $uid TEXT NOT NULL,
  $picture TEXT NOT NULL
  )
'''),
    );
  }

  Future<int> insertAllUsers(List<UserModel> users) async {
    var d = await database;
    var deleteRes = await clearAllData();
    logger.d(deleteRes);
    for (int i = 0; i < users.length; i++) {
      var r = await d.insert(myTable, users[i].toDbJson());
      // logger.d(r);
    }
    return 0;
  }

  Future<int> clearAllData() async {
    try {
      var d = await database;
      return await d.delete(myTable);
    } catch (err) {
      logger.e(err);
      throw Exception('Failed to delete the data');
    }
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<UserModel>> loadAllUsers() async {
    var d = await database;
    var res = await d.query(myTable);
    return res.map((e) => UserModel.fromDbJson(e)).toList();
  }
}
