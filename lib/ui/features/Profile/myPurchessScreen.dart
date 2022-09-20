import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';

class MyPurchessScreen extends StatelessWidget {
  const MyPurchessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: ColorManager.white,
          title: "My purchess".tr(),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: GestureDetector(
                onTap: () {
                  sl<NavigationService>().navigateTo(cart);
                },
                child: CustomSvgAssets(
                  path: IconAssets.cart,
                  color: ColorManager.black,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("YouDonthaveanypurchess".tr()),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomeCTAButton(
                trigger: false,
                primary: ColorManager.primaryGreen.withOpacity(0.04),
                title: "OrderNow",
                textColor: ColorManager.primaryGreen,
                onPressed: () {
                  sl<NavigationService>().navigateToAndRemove(home);
                },
              ),
            ],
          ),
        ));
  }
}
