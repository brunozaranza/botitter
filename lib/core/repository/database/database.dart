import 'package:bottiter/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static final String userKey = "user";

  static saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("$userKey/id", user.id);
    prefs.setString("$userKey/name", user.name);
    prefs.setString("$userKey/createdAt", user.createdAt);
    prefs.setString("$userKey/email", user.email);
    prefs.setString("$userKey/profile", user.profilePicture);
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("$userKey/id");
    String name = prefs.getString("$userKey/name");
    String createdAt = prefs.getString("$userKey/createdAt");
    String email = prefs.getString("$userKey/email");
    String profile = prefs.getString("$userKey/profile");

    if (name == null) return null;

    return User(
      id: id,
      name: name,
      createdAt: createdAt,
      email: email,
      profilePicture: profile,
    );
  }
}
