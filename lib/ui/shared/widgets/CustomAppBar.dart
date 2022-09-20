// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/resources/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Widget? leading;
  List<Widget>? actions;
  Color? backgroundColor;

  CustomAppBar({
    this.backgroundColor=ColorManager.backgroundColor,
    this.leading,
    required this.title,
    this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title.tr()),
      centerTitle: true,
      actions: actions,
      backgroundColor: backgroundColor,
      // // height: preferredSize.height,
      // color: Colors.transparent,
      // alignment: Alignment.center,
      // child: child,
    );
  }
}
