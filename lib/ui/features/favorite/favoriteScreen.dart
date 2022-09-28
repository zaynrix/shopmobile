import 'package:shopmobile/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shopmobile/ui/shared/pages/empty.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/ui/shared/pages/reConnect.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/SkeletonMobileCard.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen() {
    sl<FavouriteProvider>().getFavoriteProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            return NetworkDisconnected(onPress: () {});
          } else {
            return child;
          }
        },
        child: Consumer<FavouriteProvider>(
          builder: (context, value, child) => RefreshIndicator(
            onRefresh: value.onPageRefresh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: value.wishlistInit == true &&
                      value.favoriteDataProvider!.length == 0
                  ? SingleChildScrollView(
                      child: SkeletonMobileCardList(
                        itemCount: 10,
                      ),
                    )
                  : value.favoriteDataProvider!.length > 0
                      ? SingleChildScrollView(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: value.favoriteDataProvider!.isNotEmpty
                                  ? value.favoriteDataProvider!.length
                                  : 6,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.6, crossAxisCount: 2),
                              itemBuilder: (_, index) => CustomMobileCard(
                                  onTapDetails: () {
                                    print(
                                        "${value.favoriteDataProvider![index].product!.id}");
                                    sl<NavigationService>()
                                        .navigateTo(productDetilas, args: [
                                      value.favoriteDataProvider![index].product!.id
                                    ]);
                                  },
                                  onTap: () => value.removeFavourite(
                                      true,
                                      value.favoriteDataProvider![index].product!.id,
                                      value.favoriteDataProvider![index].id,
                                      index),
                                  images: value
                                      .favoriteDataProvider![index].product!.image,
                                  discount: value.favoriteDataProvider![index]
                                      .product!.discount,
                                  name: value
                                      .favoriteDataProvider![index].product!.name,
                                  price: value
                                      .favoriteDataProvider![index].product!.price)),
                        )
                      : EmptyScreen(
                          path: ImageAssets.splashLogoSvg,
                          title: "Your favourite is Empty",
                          subtitle: "Looks_like_favourite",
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
