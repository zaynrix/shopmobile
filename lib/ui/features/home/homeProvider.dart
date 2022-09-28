import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopmobile/dio_exception.dart';
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
  bool isInFavourite = false;
  bool notificationInit = true;

  productModel.Data? productDetails;

  int current = 0;

  // For Slider
  RangeValues rangeValues = RangeValues(20000, 30000);

  final CarouselController carouselController = CarouselController();
  TextEditingController searchController = TextEditingController();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  List<Products> products = [];
  List<Sub> searchList = [];
  List<Sub> searchListInitial = [];
  List<Banners> banners = [];
  List<NotificationItem> notifications = [];

  // Get Home
  void getHomeProvider() async {
    try {
      HomeResponse response = await sl<HomeRepo>().getHome();
      banners = response.data!.banners!;
      products = response.data!.products!;
      notifyListeners();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Get Notifications
  void getNotificationProvider() async {
    Notifications response = await sl<HomeRepo>().getNotifications();
    try {
      if (response.status == true) {
        notifications = response.data!.notification!;
        notificationInit = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      notificationInit = true;
      notifyListeners();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Get Product Details
  void getProductDetails({int? id}) async {
    try {
      productDetails = null;
      productModel.ProductModel response =
          await sl<HomeRepo>().productDetails(ProductId: id);
      productDetails = response.data!;
      notifyListeners();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  void toggleFav({bool? isFav, int? x, id}) async {
    isFav = !isFav!;
    isInFavourite = isFav;
    x != null ? products.elementAt(x).inFavorites = isInFavourite : 0;
    productDetails?.inFavorites = isInFavourite;
    notifyListeners();
    products.forEach(
      (element) {
        id == element.id ? element.inFavorites = isInFavourite : "";
        notifyListeners();
      },
    );
    sl<ExploreProvider>().topPrice.forEach(
      (element) {
        id == element.id ? element.inFavorites = isInFavourite : "";
        notifyListeners();
      },
    );
    sl<ExploreProvider>().mostViews.forEach(
      (element) {
        id == element.id ? element.inFavorites = isInFavourite : "";
        notifyListeners();
      },
    );

    sl<CategoryProvider>().subCategory.forEach(
      (element) {
        id == element.id ? element.inFavorites = isInFavourite : "";
        notifyListeners();
      },
    );
    searchList.forEach(
      (element) {
        id == element.id ? element.inFavorites = isInFavourite : "";
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

  // Generate Random Item
  List<Sub> randomLists(int n, List<Sub> source) => source.sample(n);

  // Search
  Future searchProduct({String? tex}) async {
    CategoriesDetails response = await sl<HomeRepo>().searchData(tex: tex);


      searchListInitial = randomLists(6, response.data!.sub!.reversed.toList());

      searchList = response.data!.sub!;
      notifyListeners();
      isInFavourite = true;

      notifyListeners();
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
