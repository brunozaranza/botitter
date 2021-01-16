import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/service/base_service.dart';
import 'dart:convert';

class UserService extends BaseService {

  Future<ApiResponse<List<User>>> requestAll() async {
    ApiResponse response = await getItem(endpoint: "user");
    if (response.success) {
      var userList =
          response.result.map((i) => User.fromJson(i)).cast<User>().toList();

      return ApiResponse.success(userList);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<User>> add(User user) async {
    ApiResponse response = await postItem(
      endpoint: "user",
      data: user.toJson(),
    );

    if (response.success) {
      User newUser = User.fromJson(json.decode(response.result.toString()));
      return ApiResponse.success(newUser);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<User>> edit(User user) async {
    ApiResponse response = await editItem(
      endpoint: "user",
      id: user.id,
      data: user.toJson(),
    );

    if (response.success) {
      User newUser = User.fromJson(
        json.decode(response.result.toString()),
      );
      return ApiResponse.success(newUser);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<bool>> delete(User user) async {
    ApiResponse response = await deleteItem(
      endpoint: "User",
      id: user.id,
    );

    return ApiResponse.success(response.success);
  }
}
