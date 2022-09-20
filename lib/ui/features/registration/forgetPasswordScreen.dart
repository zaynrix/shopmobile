// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../shared/widgets/CustomCTAButton.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

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
            builder: (context, value, _) => Scaffold(
                body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Form(
                key: value.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Center(
                      child: Text('Reset password',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: FontSize.s22.sp)),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                      child: Text(
                          'Enter the email associated with your account and we’ll send an email with instructions to reset your password!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: ColorManager.lightGrey,
                              fontSize: FontSize.s14.sp)),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.emailController.text = val!;
                      },
                      validator: (userName) {
                        if (userName == null || userName.isEmpty) {
                          return "Empty Your Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomeCTAButton(
                      ProgressColor: ColorManager.white,

                      trigger: value.loading,
                      primary: ColorManager.primaryGreen,
                      onPressed: () {
                        value.forgetProvider();
                        // sl<NavigationService>().navigateTo(cheackYourMail);
                      },
                      title: "Next",
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
