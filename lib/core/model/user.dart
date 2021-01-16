import 'package:bottiter/core/util/date_util.dart';
import 'package:flutter/cupertino.dart';

class User {
  String id;
  String createdAt;
  String name;
  String profilePicture;
  String email;

  User({
    @required this.name,
    @required this.email,
    this.profilePicture,
    this.id,
  }) {
    this.createdAt = DateUtil.current();
  }

  User.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.createdAt = map["created_at"];
    this.name = map["name"];
    this.profilePicture = map["profile_picture"];
    this.email = map["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    data['email'] = this.email;
    return data;
  }


  @override
  String toString() {
    return '{id: $id, created_at: $createdAt, name: $name, '
        'profile_picture: $profilePicture, email: $email}';
  }
}
