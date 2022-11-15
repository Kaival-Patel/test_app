import 'package:get/get.dart';
import 'package:simform_kaival/src/backend/api/user_nw_service.dart';
import 'package:simform_kaival/src/backend/local_database/user_local_service.dart';
import 'package:simform_kaival/src/models/user_model.dart';
import 'package:simform_kaival/src/utils/constants/constants.dart';

//DIDNT MAKE USE OF ALL THE FIELDS INSIDE USER MODEL AS TIME CONSTRAINTS ARE TIGHT SO DIDNT MADE ALL THE TABLES SEPERATELY
class UserListController extends GetxController
    with StateMixin<List<UserModel>> {
  RxBool isLoadedFromInternet = true.obs;
  RxString errorMessage = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLocalDb();
    fetchUsers();
  }

  initLocalDb() async {
    try {
      await UserLocalService().initDatabase();
    } catch (err) {
      logger.e(err);
    }
  }

  fetchUsers() async {
    change([], status: RxStatus.loading());
    try {
      var res = await UserNetworkService().getListOfUsers();
      if (res.results!.isNotEmpty) {
        change(res.results!, status: RxStatus.success());
        storeDataToLocalDb(res.results!);
      } else {
        change([], status: RxStatus.empty());
      }
      isLoadedFromInternet(true);
    } on Exception catch (err) {
      change([], status: RxStatus.error(err.toString()));
      errorMessage(err.toString());
      getDataFromLocalDb();
      isLoadedFromInternet(false);
    }
  }

  storeDataToLocalDb(List<UserModel> users) async {
    try {
      await UserLocalService().insertAllUsers(users);
    } catch (e) {
      logger.e(e);
    }
  }

  getDataFromLocalDb() async {
    try {
      change([], status: RxStatus.loading());
      var res = await UserLocalService().loadAllUsers();
      if (res.isNotEmpty) {
        change(res, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
