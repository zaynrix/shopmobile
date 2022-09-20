import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/homeModel.dart';
import 'package:shopmobile/models/notificationsModel.dart';
import 'package:shopmobile/models/productModel.dart';
import 'package:shopmobile/models/subCategoryModel.dart';
import 'package:shopmobile/utils/storage.dart';

class HomeRepo {
  final Dio? client;

  HomeRepo({this.client});

  Future<HomeResponse> getHome() async {
    print("Home");
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // print("This is ${token}");

    Response response = await client!.get('${ApiConstant.home}',
        options: Options(
          headers: <String, String>{
            "lang": "${sl<SharedLocal>().getLanguage}",
            // "Authorization": "$token"
          },
        ));
    print("This is  realUri ${response.realUri}");

    HomeResponse homeResponse = HomeResponse.fromJson(response.data);
    return homeResponse;
  }

  Future<Notifications> getNotifications() async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    print("This is ${token}");

    Response response = await client!.get('${ApiConstant.notifications}',
        options: Options(
          headers: <String, String>{ "lang": "${sl<SharedLocal>().getLanguage}", "Authorization": "$token"},
        ));
    Notifications notifications = Notifications.fromJson(response.data);
    return notifications;
  }

  Future<ProductModel> productDetails({int? ProductId}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    print("This is ${token}");

    Response response = await client!.get('${ApiConstant.products}/$ProductId',
        options: Options(
          headers: <String, String>{ "lang": "${sl<SharedLocal>().getLanguage}", "Authorization": "$token"},
        ));
    ProductModel productModel = ProductModel.fromJson(response.data);
    print("This is response ${productModel.message}");
    print("This is response ${productModel.status}");
    print("This is response ${productModel.data!.name}");

    return productModel;
  }

  Future<CategoriesDetails> searchData({String? tex}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    print("This is ${token}");

    Response response = await client!.post(
      '${ApiConstant.search}',
      data: {"text": "$tex"},
      options: Options(
        headers: <String, String>{ "lang": "${sl<SharedLocal>().getLanguage}", "Authorization": "$token"},
      ),
    );
    CategoriesDetails categoriesDetails =
        CategoriesDetails.fromJson(response.data);
    return categoriesDetails;
  }

// Future<HomeResponse> getHome() async {
//   var token =
//   await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
//   print("This is ${token}");
//
//   Response response = await client!.get('${ApiConstant.home}',
//       options: Options(
//         headers: <String, String>{"lang": "en", "Authorization": "$token"},
//       ));
//   HomeResponse homeResponse = HomeResponse.fromJson(response.data);
//   return homeResponse;
// }
}
