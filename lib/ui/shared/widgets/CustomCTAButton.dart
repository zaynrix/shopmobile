// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/resources/color_manager.dart';

class CustomeCTAButton extends StatelessWidget {
  bool trigger;
  bool haveWidget;
double heighbox;
  Widget? widget;
  bool haveBorder;
  Color colorBorder;
  Color? primary;
  Color? textColor;
  String? title;
  Color? ProgressColor;
  void Function()? onPressed;
double fontSized;
  CustomeCTAButton(
      {Key? key,
        this.widget,
        this.heighbox = 44,
        this.fontSized=17,
        this.haveWidget = true,
      this.haveBorder = false,
        this.colorBorder = ColorManager.lightGrey,
      this.ProgressColor = ColorManager.primaryGreen,
      this.trigger = true,
      this.title,
      this.primary,
      this.onPressed,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: heighbox.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primary,
              shadowColor: ColorManager.parent,
              shape: RoundedRectangleBorder(
                  side: haveBorder
                      ? BorderSide(
                          width: 1.0,
                          color:colorBorder,
                        )
                      : BorderSide(
                          width: 0.0,
                          color: ColorManager.parent,
                        ),
                  borderRadius: BorderRadius.circular(6.r)),
            ),
            onPressed: onPressed,
            child: !trigger
                ? haveWidget ? FittedBox(
                  child: Text(
                      title!.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: textColor,fontSize: fontSized),
                    ),
                ) : widget
                : FittedBox(
                  child: CircularProgressIndicator(
                      color: ProgressColor,
                    ),
                )));
  }
}
