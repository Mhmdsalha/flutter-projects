class homemodel {
  late bool status;
  homedata? data;

  homemodel.fromJson(Map<String, dynamic> Json1) {
    status = Json1['status'];
    data = (Json1['data'] != null ? homedata.fromJson(Json1['data']) : null);
  }
}

class homedata {
  List<bannersmodel>? bannerslist = [];
  List<productsmodel>? productslist = [];

  homedata.fromJson(Map<String, dynamic> Json2) {
    Json2['banners'].forEach((element) {
      bannerslist?.add(bannersmodel.fromJson(element));
    });

    Json2['products'].forEach((element) {
      productslist?.add(productsmodel.fromJson(element));
    });
  }
}

class bannersmodel {
  late int id;
  String? image;
  bannersmodel.fromJson(Map<String, dynamic> Json3) {
    id = Json3['id'];
    image = Json3['image'];
  }
}

class productsmodel {
  late String name;
  late int id;
  late dynamic price;
  late dynamic oldprice;
  late dynamic discount;
  late String image;
  late bool infavorites;
  late bool incart;

  productsmodel.fromJson(Map<String, dynamic> Json4) {
    name = Json4['name'];
    id = Json4['id'];
    price = Json4['price'];
    oldprice = Json4['old_price'];
    discount = Json4['discount'];
    image = Json4['image'];
    infavorites = Json4['in_favorites'];
    incart = Json4['in_cart'];
  }
}
