import 'dart:convert';

import 'package:shopmobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocal {
  final SharedPreferences sharedPreferences;

  SharedLocal({required this.sharedPreferences});


  // -------------------- Save User ----------------

  Future<bool> setUser(User user) async {
    String userJson = jsonEncode(user);
    return await sharedPreferences.setString(
        SharedPrefsConstant.USER, userJson);
  }


  // -------------------- Read User ----------------

  User? getUser() {
    String? user = sharedPreferences.getString(SharedPrefsConstant.USER);
    if (user != null) {
      var map =
          jsonDecode(sharedPreferences.getString(SharedPrefsConstant.USER)!);
      return User.fromJson(map);
    }
    return User(
        name: "Guest",
        phone: "",
        image: "",
        email: "",
        credit: 0,
        points: 0,
        id: 0,
        token: "");
  }


  // -------------------- Save Email ----------------

  Future<bool> setSignUpTempo(String emailUptempo) async {
    String userJson = jsonEncode(emailUptempo);
    return await sharedPreferences.setString(
        SharedPrefsConstant.phoneUptempo, userJson);
  }


  // -------------------- Read Email ----------------

  String? getSignUpTempo() {
    String? user =
        sharedPreferences.getString(SharedPrefsConstant.phoneUptempo);
    if (user != null) {
      var map = jsonDecode(
          sharedPreferences.getString(SharedPrefsConstant.phoneUptempo)!);
      return map;
    }
    return null;
  }


  // -------------------- Delete User ----------------

  void removeUser() {
    sharedPreferences.remove(SharedPrefsConstant.USER);
  }

  // -------------------- First Intro ----------------

  bool get firstIntro =>
      sharedPreferences.getBool(SharedPrefsConstant.firstIntroKey) ?? false;


  set firstIntro(bool value) {
    sharedPreferences.setBool(SharedPrefsConstant.firstIntroKey, value);
  }
  // -------------------- Language ----------------

  int get getIndexLang =>
      sharedPreferences.getInt(SharedPrefsConstant.langIndex) ?? 1;

  String get getLanguage =>
      sharedPreferences.getString(SharedPrefsConstant.langCode) ?? "en";


  set setLanguage(String langCode) {
    sharedPreferences.setString(SharedPrefsConstant.langCode, langCode);
  }

  set setLanguageIndex(int langIndex) {
    sharedPreferences.setInt(SharedPrefsConstant.langIndex, langIndex);
  }
}


// -------------------- Key Constants ----------------

class SharedPrefsConstant {
  static const String USER = 'user';
  static const String phoneUptempo = 'signUpphone';
  static const String langCode = 'langCode';
  static const String langIndex = 'langIndex';
  static const String TOKEN = 'token';
  static const String firstIntroKey = "firstIntro";
}
