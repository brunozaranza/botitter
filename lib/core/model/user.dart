import 'package:bottiter/core/util/date_util.dart';
import 'package:flutter/cupertino.dart';

class User {
  String id;
  String createdAt;
  String name;
  String avatar;
  String email;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    this.avatar,
  }) {
    this.createdAt = DateUtil.current();
  }

  User.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.createdAt = map["createdAt"];
    this.name = map["name"];
    this.avatar = map["avatar"];
    this.email = map["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
  }


  @override
  String toString() {
    return '{id: $id, createdAt: $createdAt, name: $name, avatar: $avatar, email: $email}';
  }
}
