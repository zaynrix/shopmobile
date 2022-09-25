import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/pages/empty.dart';
import 'package:shopmobile/ui/shared/pages/reConnect.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/ShimmerHelper.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen() {
    sl<HomeProvider>().getNotificationProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor,
        title: "Notification",
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: GestureDetector(
              onTap: () {},
              child: CustomSvgAssets(
                path: IconAssets.menu,
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          if (connectivity == ConnectivityResult.none) {
            return NetworkDisconnected(onPress: (){
              // sl<HomeProvider>().getHomeProvider();
            });
          } else {
            return child;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
          ),
          child: Consumer<HomeProvider>(
            builder: (context, data, child) => data.notifficationINIT == true &&
                    data.notifications.length == 0
                ? SingleChildScrollView(
                    child: ShimmerHelper().buildListShimmer(item_count: 10),
                  )
                : data.notifications.length > 0
                    ? ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: ColorManager.parent,
                        ),
                        shrinkWrap: true,
                        itemCount: data.notifications.length,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          height: 100.h,
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 100 / 100,
                                child: Container(
                                  // height: 100.h,
                                  // width: 100.w,
                                  decoration: BoxDecoration(
                                      color: ColorManager.lightPink,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  child: SizedBox(
                                    child: Padding(
                                        padding: EdgeInsets.all(14.0.w),
                                        child: Image.asset(
                                            "${ImageAssets.splashLogoPng}")),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.h, horizontal: 10.w),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "${data.notifications[index].title}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorManager
                                                          .secondColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${data.notifications[index].message}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  color: ColorManager.lightGrey),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : EmptyScreen(
                        path: ImageAssets.splashLogoSvg,
                        title: "No Notifications",
                        subtitle: "",
                      ),
          ),
        ),
      ),
    );
  }
}
