import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/addCartModel.dart';
import 'package:shopmobile/models/cartModel.dart';
import 'package:shopmobile/models/updateCartModel.dart';
import 'package:shopmobile/utils/storage.dart';

class CartRepo {
  final Dio? client;

  CartRepo({this.client});

  Future<CartModel> getCartData() async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.get('${ApiConstant.carts}',
        options: Options(
          headers: <String, String>{
            "Authorization": "$token",
            "lang": "${sl<SharedLocal>().getLanguage}",
          },
        ));
    CartModel cartModel = CartModel.fromJson(response.data);
    return cartModel;
  }

  Future<CartAddedModel> addCartData({int? id}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.post('${ApiConstant.carts}',
        data: {"product_id": id},
        options: Options(headers: <String, String>{
          "Authorization": "$token",
          "lang": "${sl<SharedLocal>().getLanguage}",
        }));
    CartAddedModel cartAddedModel = CartAddedModel.fromJson(response.data);
    print("${response.data["data"]}");
    return cartAddedModel;
  }

  Future<UpdateCartModel> cartQuantity({int? CartId, int? quantity}) async {
    print("This repo Qua $quantity");
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.put(
      '${ApiConstant.carts}/$CartId',
      data: {
        "quantity": quantity,
      },
      options: Options(headers: <String, String>{
        "Authorization": "$token",
        "lang": "${sl<SharedLocal>().getLanguage}",
      }),
    );
    UpdateCartModel updateCartModel = UpdateCartModel.fromJson(response.data);
    return updateCartModel;
  }

  Future<UpdateCartModel> deleteCart({int? CartId}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.delete(
      '${ApiConstant.carts}/$CartId',
      options: Options(headers: <String, String>{
        "Authorization": "$token",
        "lang": "${sl<SharedLocal>().getLanguage}",}),
    );
    UpdateCartModel updateCartModel = UpdateCartModel.fromJson(response.data);
    print("This is response ${response.data}");
    return updateCartModel;
  }
}
