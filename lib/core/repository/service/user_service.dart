import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/service/base_service.dart';

class UserService extends BaseService {

  Future<ApiResponse<List<User>>> requestUsers() async {
    ApiResponse response = await get(endpoint: "user");
    if (response.success) {
      var userList = response.result.map((i) =>
          User.fromJson(i)).cast<User>().toList();

      return ApiResponse.success(userList);
    } else {
      return ApiResponse.error(response.msg);
    }
  }
}