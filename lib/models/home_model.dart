class HomeData {
  bool? status;
  dynamic message;
  Data? data;
  HomeData.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fronjson(json['data']);
  }
}

class Data {
  List banners = [];
  List products = [];
  Data.fronjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannersData {
  int? id;
  dynamic image;
  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
