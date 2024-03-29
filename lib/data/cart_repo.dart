import 'package:dio/dio.dart';
import 'package:shopmobile/models/cartModel.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/models/addCartModel.dart';
import 'package:shopmobile/models/updateCartModel.dart';

class CartRepo {
  final Dio? client;

  CartRepo({this.client});


  // -------------------- Get Cart ----------------

  Future<CartModel> getCartData() async {
    Response response = await client!.get(
      '${ApiConstant.carts}',
    );
    CartModel cartModel = CartModel.fromJson(response.data);
    return cartModel;
  }


  // -------------------- Add Cart ----------------

  Future<CartAddedModel> addCartData({int? id}) async {
    Response response = await client!.post(
      '${ApiConstant.carts}',
      data: {"product_id": id},
    );
    CartAddedModel cartAddedModel = CartAddedModel.fromJson(response.data);
    return cartAddedModel;
  }


  // -------------------- Update Cart ----------------

  Future<UpdateCartModel> cartQuantity({int? CartId, int? quantity}) async {
    Response response = await client!.put(
      '${ApiConstant.carts}/$CartId',
      data: {
        "quantity": quantity,
      },
    );
    UpdateCartModel updateCartModel = UpdateCartModel.fromJson(response.data);
    return updateCartModel;
  }


  // -------------------- Delete Cart ----------------

  Future<UpdateCartModel> deleteCart({int? CartId}) async {
    Response response = await client!.delete(
      '${ApiConstant.carts}/$CartId',
    );
    UpdateCartModel updateCartModel = UpdateCartModel.fromJson(response.data);
    return updateCartModel;
  }
}
