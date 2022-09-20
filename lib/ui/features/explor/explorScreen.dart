import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:provider/provider.dart';

class Explore extends StatelessWidget {
  Explore() {
    sl<ExploreProvider>().ExploreLists();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          extendBody: true,
          backgroundColor: ColorManager.backgroundColor,
          body: SingleChildScrollView(
            child: Consumer<ExploreProvider>(
              builder: (context, value, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        child: Image.asset(
                          ImageAssets.banner2,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Price".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: ColorManager.primaryGreen),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 0.0.w),
                    child: Container(
                      height: 280.h,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 0.6,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.topPrice.length + 1,
                            itemBuilder: (_, index) {
                              if (index == value.topPrice.length) {
                                return SizedBox(width: 20.w);
                              } else if (index == 0) {
                                return SizedBox(width: 20.w);
                              } else {
                                return AspectRatio(
                                  aspectRatio: 0.6,
                                  child: CustomMobileCard(
                                    onTapDetails: (){
                                      sl<NavigationService>()
                                          .navigateTo(productDetilas,args: [value.topPrice[index].id]);
                                    },
                                    onTap: () {
                                      if (sl<CartProvider>()
                                          .isRedundentClick(DateTime.now())) {
                                        value.toggleFav(
                                            value.topPrice[index].inFavorites,
                                            index,
                                            value.topPrice[index].id,
                                            value.topPrice);
                                        print('hold on, processing');
                                        return;
                                      }
                                      print('run process');
                                    },
                                    inFavorites:
                                        value.topPrice[index].inFavorites,
                                    images: value.topPrice[index].image,
                                    discount: value.topPrice[index].discount,
                                    name: value.topPrice[index].name,
                                    price: value.topPrice[index].price,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most View".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: ColorManager.primaryGreen),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 0.0.w),
                    child: Container(
                      height: 280.h,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 0.6,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.mostViews.length + 1,
                            itemBuilder: (_, index) {
                              if (index == value.mostViews.length) {
                                return SizedBox(width: 20.w);
                              } else if (index == 0) {
                                return SizedBox(width: 20.w);
                              } else {
                                return AspectRatio(
                                  aspectRatio: 0.6,
                                  child: CustomMobileCard(
                                    onTapDetails: (){
                                      sl<NavigationService>()
                                          .navigateTo(productDetilas,args: [value.mostViews[index].id]);
                                    },
                                    onTap: () {
                                      if (sl<CartProvider>()
                                          .isRedundentClick(DateTime.now())) {
                                        value.toggleFav(
                                            value.mostViews[index].inFavorites,
                                            index,
                                            value.mostViews[index].id,
                                            value.mostViews);
                                        print('hold on, processing');
                                        return;
                                      }
                                      print('run process');
                                    },
                                    inFavorites:
                                        value.mostViews[index].inFavorites,
                                    images: value.mostViews[index].image,
                                    discount: value.mostViews[index].discount,
                                    name: value.mostViews[index].name,
                                    price: value.mostViews[index].price,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                  // Flex(
                  //   direction: Axis.horizontal,
                  //   children: [
                  //     Expanded(
                  //       child: GridView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: 2,
                  //           physics: NeverScrollableScrollPhysics(),
                  //           padding: EdgeInsets.all(0),
                  //           gridDelegate:
                  //               SliverGridDelegateWithFixedCrossAxisCount(
                  //                   childAspectRatio: 0.6, crossAxisCount: 2),
                  //           itemBuilder: (_, index) => CustomMobileCard()),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          )),
    );
  }
}
