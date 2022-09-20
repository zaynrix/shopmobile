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
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/CustomeRoundedTextFiled.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<AuthProvider>(
          builder: (context, peovider, _) => Scaffold(
              body: Form(
            key: peovider.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer(),
                    SizedBox(
                      height: 30.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sign'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: FontSize.s40.sp),
                          ),
                          TextSpan(
                            text: 'Up'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.green,
                                    fontSize: FontSize.s40.sp),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "CreateAcc".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: FontSize.s24.sp),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        path: IconAssets.profile,
                        color: ColorManager.primaryGreen,
                      ),
                      hintText: 'Fullname',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.fullname.text = val!;
                      },
                      validator: (value) => Validator.valueExists(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        path: IconAssets.email,
                        color: ColorManager.primaryGreen,
                      ),
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.emailController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validateEmail(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: Container(
                        width: 80,
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: ColorManager.primaryGreen,
                            ),
                            underline: Container(),
                            hint: Text('Please choose a location'),
                            // Not necessary for Option 1
                            value: peovider.selectedLocation,
                            onChanged: (newValue) {
                              peovider.selectNumber(newValue);
                              // setState(() {
                              //   _selectedLocation = newValue;
                              //  });
                            },
                            items: peovider.locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(
                                  location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ColorManager.primaryGreen),
                                ),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      hintText: 'Phonenumber',
                      keyboardType: TextInputType.phone,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.phone.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePhoneNumber(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      suffixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.hide,
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.lock,
                      ),
                      hintText: 'password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.passwordController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePassword(value ?? ""),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFiled(
                      suffixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.hide,
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primaryGreen,
                        path: IconAssets.lock,
                      ),
                      hintText: 'ConfirmPassword',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.done,
                      onChanged: (val) {
                        peovider.confirmPasswordController.text = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) return 'Empty'.tr();
                        if (val != peovider.passwordController.text)
                          return 'Not Match'.tr();
                        return null;
                      },//0599147563
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // CheckboxListTile(value: value, onChanged: onChanged)
                        // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
                        Theme(
                            data: ThemeData(
                                unselectedWidgetColor: const Color(0xFF667085)),
                            child: Checkbox(
                              value: peovider.rememberMe,
                              checkColor: Colors.green,
                              activeColor: Colors.white,
                              onChanged: (value) {
                                peovider.remmberMe(value!);
                              },
                            )),
                        Text('Agree with trams and condition'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: FontSize.s12.sp)),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomeCTAButton(
                      trigger: peovider.loading,
                      primary: ColorManager.secondryBlack,
                      onPressed: () {
                        peovider.SignupProvider();
                      },
                      title: "Sign Up",
                    ),

                    SafeArea(
                      bottom: true,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            sl<NavigationService>().navigateToAndRemove(login);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Haveanaccount'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: ColorManager.lightGrey),
                                ),
                                TextSpan(
                                  text: 'Login'.tr(),
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
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             RichText(
//               text:  TextSpan(children: [
//                 TextSpan(
//                   text: 'Sign',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black,fontSize: FontSize.s40.sp),),
//                 TextSpan(
//                   text: 'Up',
//                   style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.green,fontSize: FontSize.s40.sp),),
//               ]),
//             ),
//
//
//
//             Text("Create a new account!"),
//             Text("This is Center"),
//           ],
//         )
//     );
//   }
// }
