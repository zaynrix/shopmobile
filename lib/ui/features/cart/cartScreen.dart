import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/shared/pages/empty.dart';
import 'package:shopmobile/ui/shared/pages/reConnect.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/ShimmerHelper.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCart.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  final bool? show;

  Cart({this.show = false}) {
    sl<CartProvider>().getCartProvider();
  }

  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: show == true
            ? CustomAppBar(
                title: "ShoppingCart",
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
              )
            : null,
        backgroundColor: ColorManager.backgroundColor,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            if (connectivity == ConnectivityResult.none) {
              return NetworkDisconnected(onPress: () {
                // sl<HomeProvider>().getHomeProvider();
              });
            } else {
              return child;
            }
          },
          child: RefreshIndicator(
            onRefresh: () async {
              await value.refreshCart();
            },
            child: value.cartINIT == true && value.cartList.length == 0
                ? SingleChildScrollView(
                    child: ShimmerHelper().buildListShimmer(item_count: 10),
                  )
                : value.cartList.length > 0
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 16.h,
                                    ),
                                itemCount: value.cartList.length,
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      sl<NavigationService>()
                                          .navigateTo(productDetilas, args: [
                                        value.cartList[index].product!.id
                                      ]);
                                    },
                                    child: CustomCart(index: index))),
                          ),
                          // Spacer(),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    offset: Offset(0, -10.0),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                color: ColorManager.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    topRight: Radius.circular(12.r))),
                            child: SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomListTile(
                                    title: "Subtotal",
                                    trail:
                                        "${value.cartModelList == null ? 00 : value.cartTotal} AED",
                                  ),
                                  CustomListTile(
                                    title: "Discount",
                                    trail: "30%",
                                  ),
                                  CustomListTile(
                                    color: ColorManager.primaryGreen,
                                    title: "Shipping",
                                    trail: "-\$11.00",
                                    trailColor: ColorManager.primaryGreen,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: MySeparator(color: Colors.grey),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Total".tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: ColorManager.black,
                                              fontWeight:
                                                  FontWeightManager.semiBold),
                                    ),
                                    trailing: Text(
                                      "${value.cartModelList == null ? 00 : value.cartTotal} AED",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: ColorManager.black,
                                              fontWeight:
                                                  FontWeightManager.semiBold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: CustomeCTAButton(
                                      trigger: false,
                                      primary: ColorManager.secondryBlack,
                                      onPressed: () {
                                        sl<NavigationService>()
                                            .navigateTo(paymentMethodScreen);
                                      },
                                      title: "Proceedcheckout",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : EmptyScreen(
                        path: ImageAssets.splashLogoSvg,
                        title: "Your Cart is Empty",
                        subtitle: "Looks_like_cart",
                      ),
          ),
        ),
      ),
    );
  }
}

class SlideRightBackground extends StatelessWidget {
  const SlideRightBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0.r),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 30.w,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10.0.h),
                child: CustomSvgAssets(
                  path: IconAssets.delete,
                  color: ColorManager.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ],
        ),
        alignment: AlignmentDirectional.centerStart,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? trail;
  final Color? color;
  final Color? trailColor;

  CustomListTile(
      {Key? key,
      this.title,
      this.trail,
      this.color = ColorManager.darkGrey,
      this.trailColor = ColorManager.primary4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      title: Text(
        "$title".tr(),
        style: Theme.of(context).textTheme.headline4!.copyWith(color: color),
      ),
      trailing: Text(
        "$trail".tr(),
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: trailColor, fontWeight: FontWeightManager.regular),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
