import 'package:flutter/material.dart';

class CustomeSettingItemModel {
  String title;
  bool redColor;
  Widget? path;
  void Function()? onPressed;

  CustomeSettingItemModel(
      {this.path, this.onPressed,required this.title, this.redColor = false});
}
