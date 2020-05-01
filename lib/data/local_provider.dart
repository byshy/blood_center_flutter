import 'dart:async';
import 'dart:convert';

import 'package:blood_center_flutter/models/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider {
  final SharedPreferences sharedPreferences;

  LocalProvider({@required this.sharedPreferences});

  static const FIRST_LAUNCH = 'first_launch';
  static const USER = 'user';

  Future<void> setIsFirstLaunch(bool value) {
    return sharedPreferences.setBool(FIRST_LAUNCH, value);
  }

  bool getIsFirstLaunch() {
    return sharedPreferences.getBool(FIRST_LAUNCH) ?? true;
  }

  Future<void> setUser(User user) {
    String userJson = jsonEncode(user);
    return sharedPreferences.setString(USER, userJson);
  }

  User getUser() {
    String user = sharedPreferences.getString(USER);
    if(user != null){
      var map = jsonDecode(sharedPreferences.getString(USER));
      return User.fromJson(map);
    }
    return null;
  }

  void removeUser(){
    sharedPreferences.remove(USER);
  }

}
