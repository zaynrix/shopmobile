import 'package:flutter/cupertino.dart';
import 'package:shopmobile/data/favourite_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/favoritesModel.dart';
import 'package:shopmobile/models/favouriteModel.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';

class FavouriteProvider extends ChangeNotifier {
  bool isFavourite = false;
  bool wishlistInit = true;
  List<FavoriteData>? favoriteDatanew = [];
  bool isInWishList = false;

  FavouriteProvider() {

  }

  void getFavoriteProvider() async {
    Favorite res = await sl<FavouriteRepo>().getFavoriteData();
    if (res.status == true) {
      favoriteDatanew = res.data!.favoriteData;
      // favoriteDatanew!.addAll(res.data!.favoriteData!);
      wishlistInit = false;
      notifyListeners();
    } else {
      print("There is no data");
    }
  }

  reset() {
    wishlistInit = true;
    favoriteDatanew!.toSet();
    notifyListeners();
  }

  Future<void> onPageRefresh() async {
    reset();
    getFavoriteProvider();
  }

  removeFromWishList(bool? isFav, id, id2, index) async {
    FavoriteCheck res = await sl<FavouriteRepo>().removeFavoriteData(id);
    isFav = !isFav!;
    isInWishList = isFav;
    favoriteDatanew!.removeAt(index);

    if (res.status == true) {
      print("Thisis true${favoriteDatanew!}");
      print("this is product id $id ");
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
  }

  void updateFav() {
    getFavoriteProvider();
    notifyListeners();
  }
}
