import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomSettingsItem.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';

class Setting extends StatelessWidget {
   Setting({Key? key}) : super(key: key);


final  data  =sl<ProfileProvider>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: data.productDetailsScaffoldKey,
      backgroundColor: ColorManager.backgroundColor2,
      appBar:  CustomAppBar(
        backgroundColor: ColorManager.backgroundColor2,
        title:"Setting".tr(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: GestureDetector(
              onTap: () {

              },
              child: CustomSvgAssets(
                path: IconAssets.menu,
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
      body:     Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),

        child: ListView.separated(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
            height: 14.h,
            color: Colors.transparent,
          ),
          itemCount:data. subSettingItems.length,
          itemBuilder: (context, index) => CustomeSettingItem(
            onPressed:
            data. subSettingItems[index].onPressed,
            title: data.subSettingItems[index].title,
            path: data.subSettingItems[index].path,
          ),
        ),
      ),
    );
  }
}
