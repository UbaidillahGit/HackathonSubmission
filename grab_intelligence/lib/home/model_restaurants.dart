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
  String? priceRange;
  String? name;
  bool? isOk;
  String? imageUrl;

  Data(
      {this.id,
      this.category,
      this.priceRange,
      this.name,
      this.isOk,
      this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    priceRange = json['price_range'];
    name = json['name'];
    isOk = json['isOk'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['price_range'] = priceRange;
    data['name'] = name;
    data['isOk'] = isOk;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
