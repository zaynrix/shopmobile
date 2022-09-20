import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/resources/styles_manager.dart';
import 'package:shopmobile/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    dividerColor: Colors.transparent,
    // canvasColor: Colors.transparent,
    fontFamily: FontConstants.fontFamily,
    // main colors
    primaryColor: ColorManager.primaryGreen,
    // ScafolledColor
    scaffoldBackgroundColor: ColorManager.white,
    //TextTheme
    textTheme: TextTheme(
      headline1: getBoldStyle(color: ColorManager.black, fontSize: 34.sp),
      headline2: getMediumStyle(color: ColorManager.black, fontSize: 22.sp),
      headline3: getRegularStyle(color: ColorManager.black, fontSize: 17.sp),
      headline4: getLightStyle(color: ColorManager.black, fontSize: 15.sp),
      bodyText1: getRegularStyle(color: ColorManager.black, fontSize: 14.sp),
      bodyText2: getRegularStyle(color: ColorManager.black, fontSize: 13.sp),
      subtitle1: getRegularStyle(color: ColorManager.black, fontSize: 11.sp),
      subtitle2:
          getRegularStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
      button: getRegularStyle(color: ColorManager.black, fontSize: 17.sp),
      caption: getRegularStyle(color: ColorManager.black, fontSize: 12.sp),
    ),
    //CardTheme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: Colors.grey,
        elevation: AppSize.s4),
    // app bar theme

    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        // ac
        actionsIconTheme: IconThemeData(color: ColorManager.black),
        centerTitle: true,
        color: ColorManager.white,
        elevation: 0,
        titleTextStyle:
            getBoldStyle(fontSize: FontSize.s16, color: ColorManager.black)),
    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: Colors.grey,
      buttonColor: ColorManager.primaryGreen,
    ),
    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getSemiBoldStyle(
                color: ColorManager.white, fontSize: FontSize.s16),
            primary: ColorManager.primaryGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s28)))),
    // navigationBarTheme
    // navigationBarTheme:NavigationBarThemeData(backgroundColor: ColorManager.red,elevation: 5)
  );
}
