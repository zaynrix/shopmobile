import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/data/cart_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/dio_exception.dart';
import 'package:shopmobile/models/addCartModel.dart' as addCart;
import 'package:shopmobile/models/cartModel.dart' as cartModel;
import 'package:shopmobile/models/updateCartModel.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/utils/appConfig.dart';

class CartProvider extends ChangeNotifier {
  int? a;
  List<cartModel.CartItems> cartList = [];
  cartModel.CartModel? cartModelList;
  bool cartINIT = true;
  int cartTotal = 00;
  int cartLength = 0;
  var cartTotalString = ". . .";
  DateTime? clickTime;
  bool implemnt = false;
  bool sockectException = false;

  late bool emp = false;
  late int ext;

  // Clicked delay
  bool isRedundentClick(DateTime currentTime, {int sec = 10}) {
    if (clickTime == null) {
      clickTime = currentTime;
      return true;
    }
    if (currentTime.difference(clickTime!).inSeconds < sec) {
      return true;
    }
    clickTime = currentTime;
    return false;
  }

  // Cart Data
  void getCartProvider() async {
    try {
      cartModel.CartModel res = await sl<CartRepo>().getCartData();
      cartLength = res.data == null ? 0 : res.data!.cartItems!.length;

      cartList = res.data == null ? cartList : res.data!.cartItems!;
      cartModelList = res;
      cartINIT = false;
      getSetCartTotal();
      notifyListeners();
    } on DioError catch (e) {
      cartLength = 0;

      cartINIT = false;
      sockectException = true;
      notifyListeners();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Add Cart
  addToCart({int? id}) async {
    if (cartList.length == 0) {
      emp = true;
      notifyListeners();
    } else {
      cartList.forEach((element) {
        if (element.product!.id != id) {
          ext = element.product!.id!;
          implemnt = true;
          notifyListeners();
        } else {
          implemnt = false;
          notifyListeners();
        }
      });
      emp = false;
      notifyListeners();
    }

    if (implemnt == true || emp == true) {
      cartLength = cartLength + 1;
      notifyListeners();
      addCart.CartAddedModel res = await sl<CartRepo>().addCartData(id: id);

      if (res.status == true) {
        refreshCart();
        cartINIT = false;
        notifyListeners();
      } else {}
    } else {
      implemnt = false;
      notifyListeners();
      AppConfig.showSnakBar("The Item Already in Cart");
    }
    implemnt = false;
    notifyListeners();
  }

  // Delete Cart
  void deleteCartProvider({int? cartId, int? itemIndex}) async {
    UpdateCartModel res = await sl<CartRepo>().deleteCart(CartId: cartId);
    if (res.status == true) {
      cartList.removeAt(itemIndex!);
      cartLength = cartLength - 1;
      cartModelList!.data!.total = res.data!.total;
      sl<NavigationService>().pop();
      cartINIT = false;
      getSetCartTotal();
      notifyListeners();
    } else {}
  }

  // Refresh Cart
  Future refreshCart() async {
    cartModelList = null;
    cartINIT = true;
    cartList.toSet();
    getCartProvider();
    notifyListeners();
  }

  // Total Price
  int getSetCartTotal() {
    cartTotal = 0;
    if (cartList.length > 0) {
      cartList.forEach((element) {
        int? mmmm = sl<AppConfig>().checkInt(element.product?.price!.toInt());
        cartTotal += (mmmm)! * element.quantity;
        cartTotalString = "AED $cartTotal";
      });
      notifyListeners();
    }
    return cartTotal;
  }

  // Increment
  void increment({required int itemIndex, int? cartId}) async {
    cartTotal = 0;
    int quantity = await ++cartModelList!.data!.cartItems![itemIndex].quantity;

    getSetCartTotal();
    UpdateCartModel res =
        await sl<CartRepo>().cartQuantity(quantity: quantity, CartId: cartId);
    notifyListeners();

    if (res.status == true) {
      if (res.data!.total == getSetCartTotal()) {
        AppConfig.showSnakBar("${res.message}");
        notifyListeners();
      } else {}
    } else {
      AppConfig.showSnakBar("${res.message}");
    }
    notifyListeners();
  }

  // Decrement
  decrement({required int itemIndex, int? cartId}) async {
    if (cartModelList!.data!.cartItems![itemIndex].quantity <= 1) {
    } else {
      cartTotal = 0;
      int quantity =
          await cartModelList!.data!.cartItems![itemIndex].quantity--;

      getSetCartTotal();
      UpdateCartModel res =
          await sl<CartRepo>().cartQuantity(quantity: quantity, CartId: cartId);
      notifyListeners();

      if (res.status == true) {
        if (res.data!.total == getSetCartTotal()) {
          AppConfig.showSnakBar("${res.message}");
          notifyListeners();
        } else {}
      } else {
        AppConfig.showSnakBar("${res.message}");
      }
      notifyListeners();
    }
  }
}
