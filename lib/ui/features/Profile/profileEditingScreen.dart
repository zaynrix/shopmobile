import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';

class ProfileEditing extends StatelessWidget {
  const ProfileEditing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SafeArea(
              bottom: true,
              child: Form(
                key: value.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(child: Avatar()),
                    SizedBox(
                      height: 20.h,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFiled(
                      hintText: '${value.user!.phone}',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.phoneController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePhoneNumber(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      hintText: '${value.user!.name}',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.nameControllers.text = val!;
                      },
                      validator: (value) => Validator.valueExists(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      hintText: '${value.user!.email}',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.emailController.text = val!;
                      },
                      validator: (value) => Validator2.validateEmail(value ?? ""),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "Alternatemobilenumberdetails".tr(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.black),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFiled(
                      hintText: '${value.user!.phone}',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {},
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Thiswill".tr(),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.lightGrey),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomeCTAButton(
                      haveBorder: true,
                      textColor: ColorManager.lightGrey,
                      trigger: false,
                      primary: ColorManager.backgroundColor,
                      onPressed: () {
                        sl<NavigationService>().navigateTo(createNewPassword);
                      },
                      title: "Change password",
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomeCTAButton(
                      ProgressColor: ColorManager.white,
                      haveBorder: value.loading,
                      textColor: ColorManager.white,
                      trigger: value.loading,
                      primary: ColorManager.primaryGreen,
                      onPressed: () {
                        value.editProfile();
                      },
                      title: "Edit",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return Center(
          child: GestureDetector(
            onTap: () {
              value.showPicker(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: value.image != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: Image.file(
                        value.image!,
                        width: 75.w,
                        height: 75.h,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                              image: NetworkImage("${value.user!.image}")),
                          borderRadius: BorderRadius.circular(6.r)),
                      width: 75.w,
                      height: 75.h,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
