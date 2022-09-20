import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/SkeletonMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:provider/provider.dart';
final bucketGlobal = PageStorageBucket();

class Home extends StatelessWidget {
  Home() {
    sl<HomeProvider>().getHomeProvider();
  }

  @override
  Widget build(BuildContext context) {
  final state =  PageStorage.of(context)!.readState(context, identifier: 'one');
print("this is $state");
    return PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
          extendBody: true,
          backgroundColor: ColorManager.backgroundColor,
          body: Consumer2<HomeProvider, FavouriteProvider>(
            builder: (context, value, value2, child) => RefreshIndicator(
              color: ColorManager.primaryGreen,
              onRefresh: () async {
                await value.refreshHome();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            pageSnapping: true,
                            autoPlay: true,
                          ),
                          items: value.banners
                              .map(
                                (item) => Center(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    child: AspectRatio(
                                      aspectRatio: 3 / 2,
                                      child: CachedNetworkImage(
                                        // color: Colors.red,
                                        fit: BoxFit.fitHeight,
                                        placeholder: (context, url) => Center(
                                            child:
                                                const CircularProgressIndicator()),
                                        imageUrl: "${item.image}",
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PopularItem".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "SeeAll".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: ColorManager.primaryGreen),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: GridView.builder(
                              key: PageStorageKey<String>('one'),
                                shrinkWrap: true,
                                itemCount: value.products.isNotEmpty
                                    ? value.products.length
                                    : 6,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.6, crossAxisCount: 2),
                                itemBuilder: (_, index) => value
                                        .products.isNotEmpty
                                    ? CustomMobileCard(
                                        onTapDetails: () {
                                          print("${value.products[index].id}");
                                          // value.getProductDetails(
                                          //     id: value.products[index].id);
                                          sl<NavigationService>()
                                              .navigateTo(productDetilas,args: [value.products[index].id]);
                                        },
                                        onTap: () {
                                          if (sl<CartProvider>()
                                              .isRedundentClick(DateTime.now())) {
                                            value.toggleFav(
                                              isFav: value
                                                  .products[index].inFavorites,
                                              x: index,
                                              id: value.products[index].id,
                                            );
                                            print('hold on, processing');
                                            return;
                                          }
                                          print('run process');
                                        },
                                        inFavorites:
                                            value.products[index].inFavorites,
                                        images: value.products[index].image,
                                        discount: value.products[index].discount,
                                        name: value.products[index].name,
                                        price: value.products[index].price,
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
          )),
    );
  }
}
