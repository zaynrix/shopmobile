import 'package:flutter/cupertino.dart';
import 'package:shopmobile/data/favourite_repo.dart';
import 'package:shopmobile/data/home_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/homeModel.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:shopmobile/models/favouriteModel.dart' as faResponse;
import 'package:collection/collection.dart';

import '../favorite/favoriteProvider.dart';

class ExploreProvider extends ChangeNotifier {
  List<Products> topPrice = [];
  List<Products> mostViews = [];
  bool isInWishList = false;

  ExploreProvider() {
sl<HomeProvider>().getHomeProvider();
  }

  List<Products> randomLists(int n, List<Products> source) => source.sample(n);

  void ExploreLists() async {
    List<Products> productsLen = sl<HomeProvider>().products;
    if (productsLen.length > 0) {
      mostViews = randomLists(6, productsLen);
      topPrice = productsLen.where((element) => element.price! > 5000.00).toList();
      notifyListeners();
    } else {
      homeRepoData();

    }
  }

  void homeRepoData() async{
    HomeResponse response = await sl<HomeRepo>().getHome();

    if (response.status == true) {
      mostViews = randomLists(6, response.data!.products!.reversed.toList());
      topPrice = response.data!.products!
          .where((element) => element.price! > 5000.00)
          .toList();
      notifyListeners();
    } else {
      print("There is no data");
    }
  }

  toggleFav(bool? isFav, int x, id,List<Products> listt) async {
    isFav = !isFav!;
    isInWishList = isFav;
    listt.elementAt(x).inFavorites = isInWishList;
    notifyListeners();
    faResponse.FavoriteCheck favoriteCheck =
        await sl<FavouriteRepo>().removeFavoriteData(id);
    sl<HomeProvider>().products.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : !isInWishList;
        notifyListeners();
      },
    );
    sl<FavouriteProvider>().updateFav();
    notifyListeners();


    if (favoriteCheck.status == true) {
      AppConfig.showSnakBar("${favoriteCheck.message}");
    } else {
      AppConfig.showSnakBar("Something was wrong");
    }
  }
}
