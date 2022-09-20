import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';

class PrivacyScreen extends StatelessWidget {
  final data = sl<ProfileProvider>();
  PrivacyScreen(){
    data. getAboutUsProvider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor,
        title: "terms",
      ),
      body: Center(
        child:data.aboutus == null ? CircularProgressIndicator():Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Column(
              children: [
                Text(
                  "${data.aboutus == null ? "": data.aboutus!.terms}".tr(),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
