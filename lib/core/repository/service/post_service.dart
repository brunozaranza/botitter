import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/repository/service/base_service.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'dart:convert';

class PostService extends BaseService {

  Future<ApiResponse<List<Post>>> requestAll() async {
    ApiResponse response = await getItem(endpoint: "post");
    if (response.success) {
      var postList =
          response.result.map((i) => Post.fromJson(i)).cast<Post>().toList();
      return ApiResponse.success(postList);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<Post>> add(Post p) async {
    ApiResponse response = await postItem(endpoint: "post", data: p.toJson());
    if (response.success) {
      Post newPost = Post.fromJson(json.decode(response.result.toString()));
      return ApiResponse.success(newPost);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<Post>> edit(Post p) async {

    p.editedAt = DateUtil.current();

    ApiResponse response = await editItem(
      endpoint: "post",
      id: p.id,
      data: p.toJson(),
    );

    if (response.success) {
      Post newPost = Post.fromJson(json.decode(response.result.toString()));
      return ApiResponse.success(newPost);
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<bool>> delete(Post p) async {
    ApiResponse response = await deleteItem(endpoint: "post", id: p.id);
    return ApiResponse.success(response.success);
  }
}
