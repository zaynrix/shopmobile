import 'package:shopmobile/resources/assets_manager.dart';

class PaymentMethod {
  int? id;
  String? title;
  String? path;

  // void Function()? onPressed;

  PaymentMethod({this.id, this.path, this.title});

  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: 0, path: IconAssets.google, title: "Google Pay"),
    PaymentMethod(id: 1, path: IconAssets.paypal, title: "Paypal"),
    PaymentMethod(id: 2, path: IconAssets.master, title: "Mastercard"),
    PaymentMethod(id: 3, path: IconAssets.applePay, title: "Apple Pay"),
    PaymentMethod(id: 4, path: IconAssets.cash, title: "Cash on delivery"),
  ];
}
