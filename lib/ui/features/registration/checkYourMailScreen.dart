import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';

class CheackYourEmail extends StatelessWidget {
  const CheackYourEmail({Key? key}) : super(key: key);

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
        body: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 1,
                ),
                CustomSvgAssets(
                  // color: Colors.tr,
                  path: ImageAssets.phoneVerification,
                ),
                SizedBox(
                  height: 44.h,
                ),
                Text('Check your mail',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: FontSize.s22.sp)),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                    'We have sent a password recover instructions to your email.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: ColorManager.lightGrey,
                        fontSize: FontSize.s14.sp)),
                SizedBox(
                  height: 16.h,
                ),
                CustomeCTAButton(
                  primary: ColorManager.primaryGreen,
                  onPressed: () {
                    sl<NavigationService>().navigateTo(createNewPassword);
                  },
                  title: "Open email",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomeCTAButton(
                  textColor: ColorManager.lightGrey,
                  primary: ColorManager.seconderyGreen,
                  onPressed: () {},
                  title: "i’ll confirm latter",
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        )));
  }
}
