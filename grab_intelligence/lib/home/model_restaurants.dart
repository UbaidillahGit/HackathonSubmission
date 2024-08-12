class ModelRestaurants {
  List<Data>? data;

  ModelRestaurants({this.data});

  ModelRestaurants.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? category;
  String? name;
  String? priceRange;
  List<Menus>? menus;
  String? imageUrl;
  bool? isOk;

  Data(
      {this.id,
      this.category,
      this.name,
      this.priceRange,
      this.menus,
      this.imageUrl,
      this.isOk});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    priceRange = json['price_range'];
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
    imageUrl = json['imageUrl'];
    isOk = json['isOk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['name'] = name;
    data['price_range'] = priceRange;
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    data['imageUrl'] = imageUrl;
    data['isOk'] = isOk;
    return data;
  }
}

class Menus {
  String? restaurantId;
  String? price;
  String? category;
  String? name;
  String? description;

  Menus(
      {this.restaurantId,
      this.price,
      this.category,
      this.name,
      this.description});

  Menus.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    price = json['price'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurant_id'] = restaurantId;
    data['price'] = price;
    data['category'] = category;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
