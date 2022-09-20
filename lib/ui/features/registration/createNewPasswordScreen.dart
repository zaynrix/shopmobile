// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';


class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({Key? key}) : super(key: key);
  var data = sl<ProfileProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.info_outline))
          ],
          // backgroundColor: Colors.white,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<AuthProvider>(
            builder: (context, provider, _) => Scaffold(
                body: Form(
              key: data.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Center(
                      child: Text('Change password',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: FontSize.s22.sp)),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Wrap(
                      children: [
                        Text(
                          'Your new password must be different from previous used passwords.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: ColorManager.lightGrey,
                                  fontSize: FontSize.s14.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      obscureText: provider.isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          provider.visibility();
                        },
                        child: CustomSvgAssets(
                          color: ColorManager.primaryGreen,
                          path: provider.isObscure
                              ? IconAssets.hide
                              : IconAssets.show,
                        ),
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.lock,
                      ),
                      hintText: 'Current Password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        data.currentPass.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePassword(value ?? ""),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Must be at least 8 characters.",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: ColorManager.lightGrey),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.lock,
                      ),
                      hintText: 'New Password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        data.newPass.text = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) return 'Empty';
                        // if (val != provider.passwordController.text)
                        //   return 'Not Match';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomeCTAButton(
                      trigger: data.loading,
                      ProgressColor: ColorManager.white,
                      primary: ColorManager.primaryGreen,
                      onPressed: () {
                        sl<ProfileProvider>().changePasswordProvider();
                        // sl<NavigationService>().navigateTo(login);
                      },
                      title: "Confirm",
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            )),
          ),
        ));
  }
}
