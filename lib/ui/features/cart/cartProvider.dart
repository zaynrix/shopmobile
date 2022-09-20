import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/data/cart_repo.dart';
import 'package:shopmobile/di.dart';
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

  // late
  late bool emp = false;
  late int ext;

  CartProvider() {}

  bool isRedundentClick(DateTime currentTime, {int sec = 10}) {
    if (clickTime == null) {
      clickTime = currentTime;
      print("first click");
      return true;
    }
    print('diff is ${currentTime.difference(clickTime!).inSeconds}');
    if (currentTime.difference(clickTime!).inSeconds < sec) {
      print("play");
      //set this difference time in seconds
      return true;
    }
    print("stop");

    clickTime = currentTime;

    return false;
  }

  void getCartProvider() async {
    print("getFav");
    cartModel.CartModel res = await sl<CartRepo>().getCartData();
    if (res.status == true) {
      cartLength = res.data!.cartItems!.length;

      // cartList.addAll(res.data!.cartItems!);
      cartList = res.data!.cartItems!;
      cartModelList = res;
      cartINIT = false;
      getSetCartTotal();

      notifyListeners();
    } else {
      print("There is no data");
    }
  }

  addToCart({int? id}) async {
    if (cartList.length == 0) {
      // cartLength =cartList.length+1;
      notifyListeners();

      // implemnt =true;
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
        // element.id == id;
      });
      emp = false;
      notifyListeners();
    }

    print("This is impleltmt $implemnt");
    if (implemnt == true || emp == true) {
      cartLength = cartLength + 1;
      notifyListeners();

      addCart.CartAddedModel res = await sl<CartRepo>().addCartData(id: id);
      if (res.status == true) {
        // cartList.add(res.cartItemsadd);
        refreshCart();
        cartINIT = false;
        notifyListeners();
      } else {
        print("There is no data");
      }
    } else {
      implemnt = false;
      notifyListeners();
      AppConfig.showSnakBar("The Item Alread in Cart");
    }
    implemnt = false;
    notifyListeners();
  }

  void deleteCartProvider({int? cartId, int? itemIndex}) async {
    print("Delete");
    UpdateCartModel res = await sl<CartRepo>().deleteCart(CartId: cartId);
    if (res.status == true) {
      cartList.removeAt(itemIndex!);
      cartLength = cartLength - 1;
      cartModelList!.data!.total = res.data!.total;
      sl<NavigationService>().pop(); // cartModelList = res;
      // cartList.addAll(res.data!.cartItems!);
      // cartListData.addAll(res.data);
      // cartModelList = res;
      cartINIT = false;
      getSetCartTotal();

      notifyListeners();
    } else {
      print("There is no data");
    }
  }

  Future refreshCart() async {
    cartModelList = null;
    cartINIT = true;
    // cartList = [];
    cartList.toSet();
    getCartProvider();
    // cartList.toSet();
    notifyListeners();
  }

  int getSetCartTotal() {
    cartTotal = 0;

    if (cartList.length > 0) {
      cartList.forEach((element) {
        int? mmmm = sl<AppConfig>().checkInt(element.product?.price!.toInt());
        print("${element.id} + ${element.product?.price}");
        cartTotal += (mmmm)! * element.quantity;
        cartTotalString = "AED $cartTotal";
      });

      notifyListeners();
    }

    return cartTotal;
  }

  void increment({required int itemIndex, int? cartId}) async {
    print("this is cart item $cartId");
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
      } else {
        // AppConfig.showSn/akBar("Try Again");
      }
    } else {
      AppConfig.showSnakBar("${res.message}");
    }
    notifyListeners();
  }

  decrement({required int itemIndex, int? cartId}) async {
    if (cartModelList!.data!.cartItems![itemIndex].quantity <= 1) {
    } else {
      print("this is cart item $cartId");
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
        } else {
          // AppConfig.showSnakBar("Try Again");
        }
      } else {
        AppConfig.showSnakBar("${res.message}");
      }
      notifyListeners();
    }
  }
}
