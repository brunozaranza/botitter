import 'package:bottiter/core/model/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseService<T> {
  static final String baseUrl =
      "https://6001b50408587400174db4d2.mockapi.io/boticario/api/";

  Future<ApiResponse<T>> get({@required String endpoint}) async {
    try {
      var dio = Dio();

      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      Response response = await dio.get("$baseUrl$endpoint",
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(response.data);
      } else {
        return ApiResponse.error(response.statusMessage);
      }
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }

  Future<ApiResponse<T>> post(
      {@required String endpoint, Map<String, dynamic> data}) async {
    try {
      var dio = Dio();
      dynamic response = await dio.post("$baseUrl$endpoint", data: data);
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }

  Future<ApiResponse<T>> delete(
      {@required String endpoint, Map<String, dynamic> data}) async {
    try {
      var dio = Dio();
      dynamic response = await dio.delete("$baseUrl$endpoint", data: data);
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }
}
