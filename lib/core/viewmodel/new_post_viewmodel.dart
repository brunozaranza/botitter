import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/repository/service/post_service.dart';
import 'package:flutter/material.dart';

class NewPostViewModel {

  int textLength = 0;
  int maxTextLength = 280;
  double size = 20;
  bool isButtonDisabled = true;
  bool isLoading = false;

  Future<bool> addPost(Post post) async {
    ApiResponse<Post> response = await PostService().add(post);
    return response.success;
  }

  Color get indicatorColor {
    if(textLength >= maxTextLength - 20) {
      return Colors.orange;
    } else if(textLength >= maxTextLength) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Color get indicatorBackGroundColor {
    if (textLength >= maxTextLength) {
      return Colors.red;
    } else {
      return Colors.grey.shade300;
    }
  }
}