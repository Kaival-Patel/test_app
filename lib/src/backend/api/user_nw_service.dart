import 'package:simform_kaival/src/config/dio_config.dart';
import 'package:simform_kaival/src/models/api_response_model.dart';
import 'package:simform_kaival/src/models/user_model.dart';
import 'package:simform_kaival/src/utils/constants/constants.dart';

class UserNetworkService {
  Future<ApiResponse<List<UserModel>>> getListOfUsers() async {
    try {
      var res = await Api().get();
      var apiRes = ApiResponse<List<UserModel>>.fromListJson(
          res.data, (p) => p.map((e) => UserModel.fromJson(e)).toList());
      logger.d(apiRes.results!.length);
      return apiRes;
    } catch (err) {
      logger.e(err);
      throw Exception('${err.toString()}');
    }
  }
}
