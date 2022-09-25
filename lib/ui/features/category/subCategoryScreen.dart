import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/pages/reConnect.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/SkeletonMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, HomeProvider>(
      builder: (context, value, homeProvider, child) => Scaffold(
        appBar: CustomAppBar(
          title: "${value.title}",
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Badge(
                  badgeColor: ColorManager.starYellow,
                  position: BadgePosition.topEnd(top: 0, end: -10),
                  badgeContent: FittedBox(
                      child: Text(
                    "${sl<CartProvider>().cartLength}",
                    style: TextStyle(color: ColorManager.white),
                  )),
                  child: GestureDetector(
                    onTap: () {
                      sl<SharedLocal>().getUser()!.token != ""
                          ? sl<NavigationService>().navigateTo(cart)
                          : sl<NavigationService>().navigateTo(login);
                    },
                    child: CustomSvgAssets(
                      path: IconAssets.cart,
                      color: ColorManager.black,
                    ),
                  )),
            )
          ],
        ),
        extendBody: true,
        backgroundColor: ColorManager.backgroundColor,
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
          child: RefreshIndicator(
            color: ColorManager.primaryGreen,
            onRefresh: () async {
              // await value.refreshHome();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: value.subCategory.isNotEmpty
                                  ? value.subCategory.length
                                  : 6,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.6, crossAxisCount: 2),
                              itemBuilder: (_, index) => value
                                      .subCategory.isNotEmpty
                                  ? CustomMobileCard(
                                      onTapDetails: () {
                                        print(value.subCategory[index].id);
                                        sl<NavigationService>().navigateTo(
                                            productDetilas,
                                            args: [value.subCategory[index].id]);
                                      },
                                      onTap: () {
                                        if (sl<CartProvider>()
                                            .isRedundentClick(DateTime.now())) {
                                          homeProvider.toggleFav(
                                            isFav: value
                                                .subCategory[index].inFavorites,
                                            // x: index,
                                            id: value.subCategory[index].id,
                                          );
                                          print('hold on, processing');
                                          return;
                                        }
                                        print('run process');
                                      },
                                      inFavorites:
                                          value.subCategory[index].inFavorites,
                                      images: value.subCategory[index].image,
                                      discount: value.subCategory[index].discount,
                                      name: value.subCategory[index].name,
                                      price: value.subCategory[index].price,
                                    )
                                  : SkeletonMobileCard()),
                        ),
                      ],
                    )
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
