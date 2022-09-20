import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomSettingsItem.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final user = sl<SharedLocal>().getUser();
  final profileProvider = sl<ProfileProvider>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: profileProvider.productDetailsScaffoldKey,
        backgroundColor: ColorManager.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  leading: CachedNetworkImage(
                    imageUrl: "${user!.image}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider),
                        // color: ColorManager.primaryGreen,
                        borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                      ),
                      width: 70.w,
                      height: 70.h,
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: ColorManager.primaryGreen,
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: ColorManager.primaryGreen,
                        borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                      ),
                      width: 70.w,
                      height: 70.h,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Center(
                            child: Text(
                          user?.name![0] ?? "Guest"[0],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  title: Text(
                    "${user?.name ?? "Guest"}",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      if(sl<SharedLocal>().getUser()!.token != ""){
                      sl<NavigationService>().navigateTo(editProfile);

                      }
                    },
                    child: CustomSvgAssets(
                      path: IconAssets.arrowRight,
                      color: ColorManager.lightGrey,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 25.h,
              // ),
              // CustomeSettingItem(
              //   onPressed: ()async {
              //     sl<AuthProvider>().logoutProvider();
              //    await Phoenix.rebirth(context);
              //   },
              //   title: "Loguouttt",
              //   path: IconAssets.logout,
              // ),
              SizedBox(
                height: 25.h,
              ),
              // Expanded(
              //   child: Consumer<HomeProvider>(
              //     builder: (context, data, child) => ListView.separated(
              //         shrinkWrap: true,
              //         // physics: NeverScrollableScrollPhysics(),
              //         separatorBuilder: (context, index) => Divider(
              //               height: 14.h,
              //               color: Colors.transparent,
              //             ),
              //         itemCount:homeProvider.SettingItems.length,
              //         itemBuilder: (context, index) {
              //           return CustomeSettingItem(
              //               onPressed: homeProvider.SettingItems[index].onPressed,
              //               title: homeProvider.SettingItems[index].title!,
              //               path: homeProvider.SettingItems[index].path);
              //         }),
              //   ),
              // ),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, data, child) => ListView
                      .separated(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      height: 14.h,
                      color: Colors.transparent,
                    ),
                    itemCount:profileProvider. SettingItems.length,
                    itemBuilder: (context, index) {
                      return

                        CustomeSettingItem(
                          redColor: profileProvider.SettingItems[index].redColor,
                          onPressed:profileProvider. SettingItems[index].onPressed,
                          title: profileProvider.SettingItems[index].title,
                          // redColor: profileProvider.SettingItems.last ==false ,

                          path: profileProvider.SettingItems[index].path);
                    },
                  ),
                ),
              ),
            ],
          ),
        )
        // : Center(
        //     child: Text("Somthing Wrong"),
        //   ),
        );
  }
}
