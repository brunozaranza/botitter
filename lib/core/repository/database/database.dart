import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Database {
  static final String userKey = "user";

  static Future<bool> saveData<T>(String key, T data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime date = DateTime.now();

    bool success;

    if (data is String) {
      success = await prefs.setString(key, data);
    } else if (data is int) {
      success = await prefs.setInt(key, data);
    } else if (data is double) {
      success = await prefs.setDouble(key, data);
    } else if (data is bool) {
      success = await prefs.setBool(key, data);
    }

    if (success) {
      prefs.setString("$key.upload", DateUtil.parseDateToString(date));
    }

    return success;
  }

  static saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, user.toString());
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString(userKey);
    try {
      Map userMap = json.decode(userString);
      return User.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

}