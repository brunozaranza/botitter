import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'package:flutter/material.dart';

class Post {
  String id;
  String createdAt;
  String editedAt;
  String content;
  String imageUrl;
  String link;
  User user;

  Post({
    this.id,
    this.user,
    this.content,
    this.imageUrl,
    this.editedAt,
    this.link,
  }) {
    this.createdAt = DateUtil.current();
  }

  Post.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.createdAt = map["created_at"];
    this.editedAt = map["edited_at"];
    this.content = map["content"];
    this.imageUrl = map["image_url"];
    this.link = map["link"];
    if(map.containsKey("user")) this.user = User.fromJson(map["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['edited_at'] = this.editedAt;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    data['link'] = this.link;
    data['user'] = this.user;
    return data;
  }

  @override
  String toString() {
    return '{id: $id, created_at: $createdAt, edited_at: $editedAt, '
        'content: $content, image_url: $imageUrl, link: $link, user: ${user.toString()}';
  }
}