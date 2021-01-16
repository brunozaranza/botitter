import 'package:bottiter/core/util/date_util.dart';
import 'package:flutter/cupertino.dart';

class Post {
  String id;
  String createdAt;
  String content;
  String imageUrl;
  String link;
  String user;

  Post({
    @required this.user,
    @required this.content,
    this.imageUrl,
    this.link,
  }) {
    this.createdAt = DateUtil.current();
  }

  Post.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.createdAt = map["createdAt"];
    this.content = map["content"];
    this.imageUrl = map["imageUrl"];
    this.link = map["link"];
    this.user = map["user"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['content'] = this.content;
    data['imageUrl'] = this.imageUrl;
    data['link'] = this.link;
    data['user'] = this.user;
    return data;
  }

  @override
  String toString() {
    return '{id: $id, createdAt: $createdAt, content: $content,'
        'imageUrl: $imageUrl, link: $link, user: $user}';
  }


}