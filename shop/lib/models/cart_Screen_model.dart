class cart_Screen_model {
  bool? status;
  String? message;
  Data? data;

  cart_Screen_model({this.status, this.message, required this.data});

  cart_Screen_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null);
  }
}

class Data {
  List<CartItems>? data;
  int? subTotal;
  int? total;

  Data({required this.data, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      data = <CartItems>[];
      json['cart_items'].forEach((v) {
        data!.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  late int id;
  late int quantity;
  late Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        (json['product'] != null ? Product.fromJson(json['product']) : null)!;
  }
}

class Product {
  late int id;
  late int price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  late bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
