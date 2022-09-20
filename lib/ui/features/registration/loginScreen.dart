import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<AuthProvider>(builder: (context, value, _) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: value.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome'.tr(),
                            style: AppConfig()
                                .getTextContext(context)
                                .headline1!
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: FontSize.s30.sp),
                            // Theme.of(context).textTheme.
                          ),
                          TextSpan(
                            text: 'back'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.green,
                                    fontSize: FontSize.s30.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.profile,
                      ),
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.emailController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validateEmail(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      obscureText: value.isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          value.visibility();
                        },
                        child: CustomSvgAssets(
                          color: ColorManager.primaryGreen,
                          path: value.isObscure
                              ? IconAssets.hide
                              : IconAssets.show,
                        ),
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.lock,
                      ),
                      hintText: 'password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.passwordController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePassword(value ?? ""),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        sl<NavigationService>().navigateTo(forgetPassword);
                      },
                      child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "Forget password".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: ColorManager.secondryBlack),
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomeCTAButton(
                      trigger: value.loading,
                      primary: ColorManager.secondryBlack,
                      onPressed: () {
                        // Login Function
                        value.loginProvider();
                      },
                      title: "Login",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     sl<NavigationService>().navigateToAndRemove(home);
                    //   },
                    //   child: Center(child: Text("guest".tr())),
                    // ),//123123123
                    Spacer(),
                    SafeArea(
                      bottom: true,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            sl<NavigationService>().navigateToAndRemove(signUp);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'HaventAccount'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: ColorManager.lightGrey),
                                ),
                                TextSpan(
                                  text: 'SignUp'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ColorManager.primaryGreen,
                                          fontWeight:
                                              FontWeightManager.semiBold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
