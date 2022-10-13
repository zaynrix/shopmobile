import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/models/homeModel.dart';
import 'package:shopmobile/models/productModel.dart';
import 'package:shopmobile/models/notificationsModel.dart';
import 'package:shopmobile/models/subCategoryModel.dart';

class HomeRepo {
  final Dio? client;

  HomeRepo({this.client});


  // -------------------- Get Home ----------------

  Future<HomeResponse> getHome() async {
    Response response = await client!.get('${ApiConstant.home}',);
    HomeResponse homeResponse = HomeResponse.fromJson(response.data);
    return homeResponse;
  }


  // -------------------- Get Notifications ----------------

  Future<Notifications> getNotifications() async {
    Response response = await client!.get('${ApiConstant.notifications}',);
    Notifications notifications = Notifications.fromJson(response.data);
    return notifications;
  }


  // -------------------- Get Product Details ----------------

  Future<ProductModel> productDetails({int? ProductId}) async {
    Response response = await client!.get('${ApiConstant.products}/$ProductId',);
    ProductModel productModel = ProductModel.fromJson(response.data);
    print("This is response ${productModel.message}");
    return productModel;
  }


  // -------------------- Search Products ----------------

  Future<CategoriesDetails> searchData({String? tex}) async {
    Response response = await client!.post('${ApiConstant.search}', data: {"text": "$tex"},);
    CategoriesDetails categoriesDetails =
        CategoriesDetails.fromJson(response.data);
    return categoriesDetails;
  }
}
