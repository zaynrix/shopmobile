class UpdateCartModel {
  bool? status;
  String? message;
  Data? data;

  UpdateCartModel({this.status, this.message, this.data});

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Cart? cart;
  num? subTotal;
  num? total;

  Data({this.cart, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    return data;
  }
}

class Cart {
  int? id;
  int? quantity;
  Product? product;

  Cart({this.id, this.quantity, this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  num? price;
  num? oldPrice;
  int? discount;
  String? image;

  Product({this.id, this.price, this.oldPrice, this.discount, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] ;
    oldPrice = json['old_price'] ;
    discount = json['discount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    return data;
  }
}