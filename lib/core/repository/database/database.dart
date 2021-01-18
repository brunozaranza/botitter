import 'package:bottiter/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static final String userKey = "user";

  static saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user != null) {
    prefs.setString("$userKey/id", user.id);
    prefs.setString("$userKey/name", user.name);
    prefs.setString("$userKey/createdAt", user.createdAt);
    prefs.setString("$userKey/email", user.email);
    prefs.setString("$userKey/profile", user.profilePicture);
    } else {
      prefs.setString("$userKey/name", "");
    }
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("$userKey/name") == "" ? null: prefs.getString("$userKey/name");
    if (name == null) return null;

    String id = prefs.getString("$userKey/id");
    String createdAt = prefs.getString("$userKey/createdAt");
    String email = prefs.getString("$userKey/email");
    String profile = prefs.getString("$userKey/profile");

    return User(
      id: id,
      name: name,
      createdAt: createdAt,
      email: email,
      profilePicture: profile,
    );
  }
}
