import 'dart:async';
import 'package:shopmobile/models/notificationsModel.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/data/favourite_repo.dart';
import 'package:shopmobile/data/home_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/favouriteModel.dart' as faResponse;
import 'package:shopmobile/models/homeModel.dart';
import 'package:shopmobile/models/productModel.dart' as productModel;
import 'package:shopmobile/models/subCategoryModel.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:collection/collection.dart';

class HomeProvider extends ChangeNotifier {
  bool? changed = false;
  int current = 0;
  RangeValues rangeValues = RangeValues(20000, 30000);

  bool isInWishList = false;
  bool notifficationINIT = true;
  productModel.Data? productDetails;

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final CarouselController carouselController = CarouselController();
  TextEditingController searchController = TextEditingController();

// final pageStroeKey = PageStorageKey("HomeKey");
  List<Products> products = [];
  List<Sub> searchList = [];
  List<Sub> searchListInitial = [];
  List<Banners> banners = [];
  List<NotificationItem> notifications = [];

  void getHomeProvider() async {
    //("Added Data");
    try {
      searchProduct(tex: "Xiam");
      HomeResponse response = await sl<HomeRepo>().getHome();
      if (response.status == true) {
        banners = response.data!.banners!;
        products = response.data!.products!;
        notifyListeners();
      } else {}
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    // sl<CartProvider>().cartList.clear();
    // sl<CartProvider>().ext = 0;
    // sl<CartProvider>().implemnt = false;
    // sl<CartProvider>().cartModelList = null;
    //
    // sl<CategoryProvider>().category.clear();
    // sl<CategoryProvider>().subCategory.clear();
    // sl<ExploreProvider>().topPrice.clear();
    // sl<ExploreProvider>().mostViews.clear();
    // sl<FavouriteProvider>().favoriteDatanew!.clear();
    // sl<HomeProvider>().banners.clear();
    // sl<ProfileProvider>().address.clear();
    // sl<HomeProvider>().products.clear();
    // sl<HomeProvider>().searchList.clear();
    // sl<HomeProvider>().controller.dispose();
    // sl<HomeProvider>().searchController.dispose();
    // sl<HomeProvider>().productDetails = null;
    // sl<HomeProvider>().productDetails = null;// TODO: implement dispose

    //  This is data
    //  sl<CartProvider>().cartList;
    //  sl<CartProvider>().ext ;
    //  sl<CartProvider>().implemnt ;
    //  sl<CartProvider>().cartModelList;
    //
    //  sl<CategoryProvider>().category;
    //  sl<CategoryProvider>().subCategory;
    //  sl<ExploreProvider>().topPrice;
    //  sl<ExploreProvider>().mostViews;
    //  sl<FavouriteProvider>().favoriteDatanew!;
    //  sl<HomeProvider>().banners;
    //  sl<ProfileProvider>().address;
    //  sl<HomeProvider>().products;
    //  sl<HomeProvider>().searchList;
    //  sl<HomeProvider>().controller;
    //  sl<HomeProvider>().searchController;
    //  sl<HomeProvider>().productDetails;
    //  sl<HomeProvider>().productDetails;// TODO: implement dispose
    super.dispose();
  }

  void getNotificationProvider() async {
    Notifications response = await sl<HomeRepo>().getNotifications();
   try{



    if (response.status == true) {
      notifications = response.data!.notification!;
      notifficationINIT = false;
      notifyListeners();
    }
   }catch(e){
     notifficationINIT = true;
     notifyListeners();

   }
  }

  void getProductDetails({int? id}) async {
    productDetails = null;

    productModel.ProductModel response =
    await sl<HomeRepo>().productDetails(ProductId: id);

    if (response.status == true) {
      productDetails = response.data!;
      notifyListeners();
    } else {
    }
  }

  void toggleFav({bool? isFav, int? x, id}) async {
    isFav = !isFav!;
    isInWishList = isFav;
    x != null ? products
        .elementAt(x)
        .inFavorites = isInWishList : 0;
    productDetails?.inFavorites = isInWishList;
    notifyListeners();
    products.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : "";
        notifyListeners();
      },
    );
    sl<ExploreProvider>().topPrice.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : "";
        notifyListeners();
      },
    );
    sl<ExploreProvider>().mostViews.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : "";
        notifyListeners();
      },
    );

    sl<CategoryProvider>().subCategory.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : "";
        notifyListeners();
      },
    );
    searchList.forEach(
          (element) {
        id == element.id ? element.inFavorites = isInWishList : "";
        notifyListeners();
      },
    );
    notifyListeners();
    faResponse.FavoriteCheck favoriteCheck =
    await sl<FavouriteRepo>().removeFavoriteData(id);

    sl<FavouriteProvider>().updateFav();
    notifyListeners();

    if (favoriteCheck.status == true) {
      AppConfig.showSnakBar("${favoriteCheck.message}");
    } else {
      AppConfig.showSnakBar("Somthing was wrong");
    }
  }

  refreshHome() async {
    banners.clear();
    products.clear();
    getHomeProvider();
    notifyListeners();
  }

  refreshSearch() async {
    searchList.clear();
    // products.clear();
    searchProduct(tex: "");
    notifyListeners();
  }

  void indexChange({int? index}) {
    current = index!;
    notifyListeners();
  }

  List<Sub> randomLists(int n, List<Sub> source) => source.sample(n);

  Future searchProduct({String? tex}) async {
    CategoriesDetails response = await sl<HomeRepo>().searchData(tex: tex);

    //(response.status);
    if (response.status == true) {
      searchListInitial = randomLists(6, response.data!.sub!.reversed.toList());

      searchList = response.data!.sub!;
      notifyListeners();
      // filter(searchController.text);
      isInWishList = true;

      notifyListeners();
    } else {
      //("There is no data");
    }
  }

  rangeChanged(RangeValues values) {
    // setState(() {
    if (values.end - values.start >= 1000) {
      rangeValues = values;
      notifyListeners();
    } else {
      if (rangeValues.start == values.start) {
        rangeValues = RangeValues(rangeValues.start, rangeValues.start + 1000);
        notifyListeners();
      } else {
        rangeValues = RangeValues(rangeValues.end - 1000, rangeValues.end);
        notifyListeners();
      }
    }
    notifyListeners();
    // });
  }

  filterCars() {
    // Prepare lists
    List<Sub> tmp = [];
    // tmp.clear();
    // searchList.clear();
    notifyListeners();
// searchProduct(tex: "");
    String name = searchController.text;
    //("filter cars for name " + name);
    if (name.isEmpty && searchList.isEmpty) {
      searchProduct(tex: "").then((value) {
        if (value != null) {
          for (Sub c in searchList) {
            if (c.price! >= rangeValues.start && c.price! <= rangeValues.end) {
              tmp.add(c);
              notifyListeners();
            }
          }
        } else {}
      });
      tmp.addAll(searchList);
      notifyListeners();
    } else {
      for (Sub c in searchList) {
        //(
        //     "c.price! ${c.price!}  rangeValues.start ${rangeValues.start}  - rangeValues.end ${rangeValues.end} ");
        if (c.price! >= rangeValues.start && c.price! <= rangeValues.end) {
          tmp.add(c);
          notifyListeners();
        }
      }
    }
    searchList = tmp;
    notifyListeners();
    sl<NavigationService>().pop();
  }

  selectedFilter() {
    //("Clicked");

    filterCars();
    searchList.forEach((element) {
      bool attr = element.price! <= rangeValues.start &&
          element.price! >= rangeValues.end;
      if (attr == true) {
        searchList.add(element);
        notifyListeners();
      }
    });

    notifyListeners();
    sl<NavigationService>().pop();
    //("after searchProduct");
  }

  StreamController<List<Sub>> streamController = BehaviorSubject();

  Stream<List<Sub>> get stream => streamController.stream;

  filter(String searchQuery) {
    List<Sub> filteredList = searchList
        .where((Sub user) =>
        user.name!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    streamController.sink.add(filteredList);
  }
}
