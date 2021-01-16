import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/repository/service/base_service.dart';

class PostService extends BaseService {

  Future<ApiResponse<List<Post>>> requestPosts() async {
    ApiResponse response = await get(endpoint: "post");
    if (response.success) {
      var postList = response.result.map((i) =>
          Post.fromJson(i)).cast<Post>().toList();

      return ApiResponse.success(postList);
    } else {
      return ApiResponse.error(response.msg);
    }
  }
}