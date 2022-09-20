import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/resources/styles_manager.dart';

import '../../../resources/color_manager.dart';

class CustomTextFiled extends StatelessWidget {
   CustomTextFiled(
      {required this.onChanged,
      required this.hintText,
      required this.focuse,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.prefixIcon,
        this.inputFormatters,
      this.textInputAction = TextInputAction.next,
      this.suffixIcon});
   final List<TextInputFormatter>? inputFormatters;
  final Function(String?) onChanged;
  final void Function(String) focuse;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 10),
            color: ColorManager.black.withOpacity(0.03),
            blurRadius: 20)
      ]),
      child: TextFormField(
        inputFormatters: inputFormatters ?? [],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.text,
        onFieldSubmitted: focuse,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText.tr(),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: true,
          // errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          hintStyle: getRegularStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s16.sp),
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            //com
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF3C3C43),
        ),
      ),
    );
  }
}
