import 'package:bottiter/core/model/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseService<T> {
  static final String baseUrl =
      "https://6001b50408587400174db4d2.mockapi.io/boticario/api/";

  Future<ApiResponse<T>> getItem({String endpoint, String url}) async {
    try {
      var dio = Dio();

      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      Response response = await dio.get(url == null ? "$baseUrl$endpoint" : url,
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

  Future<ApiResponse<T>> postItem(
      {@required String endpoint, Map<String, dynamic> data}) async {
    try {
      var dio = Dio();
      dynamic response = await dio.post("$baseUrl$endpoint", data: data);
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }

  Future<ApiResponse<T>> editItem(
      {@required String endpoint, @required String id,
        @required Map<String, dynamic> data}) async {
    try {
      var dio = Dio();
      dynamic response = await dio.put("$baseUrl$endpoint/$id", data: data);
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }

  Future<ApiResponse<T>> deleteItem(
      {@required String endpoint, @required String id}) async {
    try {
      var dio = Dio();
      dynamic response = await dio.delete("$baseUrl$endpoint/$id");
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }
}
