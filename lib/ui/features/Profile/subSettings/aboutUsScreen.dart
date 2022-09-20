import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';

class AboutUsScreen extends StatelessWidget {
  final data = sl<ProfileProvider>();
  AboutUsScreen(){
    data. getAboutUsProvider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor,
        title: "Abouts",
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              CustomSvgAssets(
                path: ImageAssets.splashLogoSvg,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "${data.aboutus!.about ?? ""}".tr(),
                overflow: TextOverflow.visible,
              ),
              Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Version".tr()),
                    Text("1.1"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
