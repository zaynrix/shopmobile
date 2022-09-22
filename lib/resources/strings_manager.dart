import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  var Settings = "Setting".tr();
  static const signUp = 'إنشاء حساب جديد';
}

class Endpoints {
  Endpoints._();

  // base url
  static String baseUrl = "https://reqres.in/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String users = '/users';
}
