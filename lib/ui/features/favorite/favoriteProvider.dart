import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmobile/data/favourite_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/dio_exception.dart';
import 'package:shopmobile/models/favoritesModel.dart';
import 'package:shopmobile/models/favouriteModel.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/utils/appConfig.dart';

class FavouriteProvider extends ChangeNotifier {
  bool isFavourite = false;
  bool wishlistInit = true;
  List<FavoriteData>? favoriteDataProvider = [];
  bool isInWishList = false;

  // Get Favourite
  void getFavoriteProvider() async {
    try {
      Favorite res = await sl<FavouriteRepo>().getFavoriteData();
      favoriteDataProvider =
          res.data == null ? favoriteDataProvider : res.data!.favoriteData;
      wishlistInit = false;
      notifyListeners();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Reset Favourite
  reset() {
    wishlistInit = true;
    favoriteDataProvider!.toSet();
    notifyListeners();
  }

  // Refresh Favourite
  Future<void> onPageRefresh() async {
    reset();
    getFavoriteProvider();
  }

  removeFavourite(bool? isFav, id, id2, index) async {
    try {
      FavoriteCheck res = await sl<FavouriteRepo>().removeFavoriteData(id);
      isFav = !isFav!;
      isInWishList = isFav;
      favoriteDataProvider!.removeAt(index);

      if (res.status == true) {
        sl<HomeProvider>().products.forEach((element) {
          id == element.id ? element.inFavorites = false : "";
          notifyListeners();
        });
        sl<ExploreProvider>().topPrice.forEach((element) {
          id == element.id ? element.inFavorites = false : "";
          notifyListeners();
        });
        sl<ExploreProvider>().mostViews.forEach((element) {
          id == element.id ? element.inFavorites = false : "";
          notifyListeners();
        });
        sl<CategoryProvider>().subCategory.forEach((element) {
          id == element.id ? element.inFavorites = false : "";
          notifyListeners();
        });
        updateFav();
        notifyListeners();
      } else {}
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Update Favourite
  void updateFav() {
    getFavoriteProvider();
  }
}
