import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';

class BotNew {
  User user;
  Post post;

  BotNew({
    this.user,
    this.post,
  });

  BotNew.fromJson(Map<String, dynamic> map) {
    this.user = User.fromJson(map["user"]);
    this.post = Post.fromJson(map["message"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['message'] = this.post;
    return data;
  }

  @override
  String toString() {
    return '{user: $user, message: $post}';
  }
}
