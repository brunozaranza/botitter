import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/database/database.dart';
import 'package:bottiter/core/repository/service/user_service.dart';
import 'package:bottiter/core/store/user_store.dart';
import 'package:flutter/material.dart';

class LoginViewModel {

  UserStore store;
  bool isRememberMe = true;
  bool isLoading = false;

  LoginViewModel({@required this.store});

  Future<User> fetchUser(String email) async {
    ApiResponse<List<User>> response = await UserService().requestAll();
    if(response.success) {

      for (User u in response.result) {
        if (u.email == email) {
         this.store.setUser(u);

          if(rememberMe) saveUser(u);

          return u;
        }
      }

      return null;
    } else {
      return null;
    }
  }

  Future<User> addUser(User user) async {
    ApiResponse<User> response = await UserService().add(user);
    if(response.success) {
      return response.result;
    } else {
      return null;
    }
  }

  saveUser(User user) {
    Database.saveUser(user);
  }

  get user {
    return store.user;
  }

  set user(User u) {
    store.setUser(u);
  }

  get loading {
    return isLoading;
  }

  set loading(bool value) {
    isLoading = value;
  }

  get rememberMe {
    return isRememberMe;
  }

  set rememberMe(bool value) {
    this.isRememberMe = value;
  }

  dispose() {
    store.dispose();
  }

}