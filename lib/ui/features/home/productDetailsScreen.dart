import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeDiscount.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  final int? id;

  ProductDetails({Key? key, this.id}) {
    sl<HomeProvider>().getProductDetails(id: id);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.white,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.white,
          title: "",
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Badge(
                  badgeColor: ColorManager.starYellow,
                  position: BadgePosition.topEnd(top: 0, end: -10),
                  badgeContent: FittedBox(child: Text("${sl<CartProvider>().cartLength}",style: TextStyle(color: ColorManager.white),)),
                  child: GestureDetector(
                    onTap: () {
                      sl<SharedLocal>().getUser()!.token != ""
                          ?
                      sl<NavigationService>().navigateTo(cart):
                      sl<NavigationService>().navigateTo(login);

                    },
                    child: CustomSvgAssets(
                      path: IconAssets.cart,
                      color: ColorManager.black,
                    ),
                  )),
            )
           
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: value.productDetails != null
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, -10.0),
                      blurRadius: 14.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  color: ColorManager.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomeCTAButton(
                          primary: value.productDetails?.inFavorites != false
                              ? ColorManager.primaryGreen
                              : ColorManager.lightGrey,
                          onPressed: () {
                            if(sl<SharedLocal>().getUser()!.token != ""){

                            if (sl<CartProvider>()
                                .isRedundentClick(DateTime.now())) {
                              value.toggleFav(
                                isFav: value.productDetails!.inFavorites,
                                id: // index,
                                    value.productDetails!.id,
                              );
                              print('hold on, processing');
                              return;
                            }
                            print('run process');
                            print("hertOutlined");
                            }else{          AppConfig.showSnakBar("You Should login");


                            }
                          },
                          trigger: false,
                          haveWidget: false,
                          widget: CustomSvgAssets(
                            color: ColorManager.white,
                            path: IconAssets.hertOutlined,
                          ),
                          title: "",
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomeCTAButton(
                          onPressed:
                          sl<SharedLocal>().getUser()!.token != ""
                              ? (){
                            sl<CartProvider>()
                                .addToCart(id: value.productDetails?.id);
                            print("Cart");
                          }:() {

                            AppConfig.showSnakBar("You Should login");

                          },
                          haveWidget: true,
                          textColor: ColorManager.white,
                          trigger: false,
                          primary: ColorManager.secondColor,
                          title: "AddToCart",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: ColorManager.parent,
                ),
              ),
        body: value.productDetails != null
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: CustomSvgAssets(
                              fit: BoxFit.fitWidth,
                              color: ColorManager.primaryGreen,
                              path: ImageAssets.detailsBackgoung,
                            ),
                          ),
                          Container(
                            child: CarouselSlider.builder(
                              carouselController: value.carouselController,
                              itemCount: value.productDetails!.images!.length,
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 14 / 9,
                                enlargeCenterPage: true,
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 2),
                                autoPlayInterval: const Duration(seconds: 4),
                                autoPlayCurve: Curves.easeInOutSine,
                                onPageChanged: (index, reason) {
                                  value.indexChange(index: index);
                                },
                                scrollPhysics: const BouncingScrollPhysics(),
                              ),
                              itemBuilder: (context, index, realIdx) {
                                return index == value.current
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              // color: Colors.red,
                                              fit: BoxFit.fitHeight,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      const CircularProgressIndicator()),
                                              imageUrl:
                                                  "${value.productDetails!.images![index]}",
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5.0)),
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  // color: Colors.red,
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              const CircularProgressIndicator(color: ColorManager.primaryGreen,)),
                                                  imageUrl:
                                                      "${value.productDetails!.images![index]}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSmoothIndicator(
                              activeIndex: value.current,
                              count: value.productDetails!.images!.length,
                              effect: ExpandingDotsEffect(
                                radius: 10,
                                dotWidth: 10,
                                dotHeight: 10,
                                activeDotColor: Colors.green,
                                expansionFactor: 4,
                                dotColor: Colors.green.withOpacity(0.17),
                              ), // your preferred effect
                              onDotClicked: (index) {
                                value.controller.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 25, end: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${value.productDetails!.name!}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            CustomeDiscount(
                              discount: value.productDetails!.discount,
                              radius: 32,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("${value.productDetails!.oldPrice!} AED",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: ColorManager.primaryGreen,
                                        fontWeight: FontWeightManager.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 25, end: 16),
                        child: CustomeRating(
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 25, end: 16),
                        child: Text("Descriptions".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontWeight: FontWeightManager.bold)),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 25, end: 16),
                        child: Text("${value.productDetails!.description!}",
                            style: Theme.of(context).textTheme.bodyText1!,
                            maxLines: 1000),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: ColorManager.primaryGreen,),
              ),
      ),
    );
  }
}
