// To parse this JSON data, do
//
//     final subCategModel = subCategModelFromJson(jsonString);

import 'dart:convert';

List<SubCategModel> subCategModelFromJson(String str) => List<SubCategModel>.from(json.decode(str).map((x) => SubCategModel.fromJson(x)));

String subCategModelToJson(List<SubCategModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategModel {
  SubCategModel({
    this.photo,
    required this.id,
    required this.name,
    required this.photoName,
    required this.categoryId,
    required this.category,
    required this.product,
  });

  dynamic photo;
  int id;
  String name;
  String photoName;
  int categoryId;
  Category category;
  List<dynamic> product;

  factory SubCategModel.fromJson(Map<String, dynamic> json) => SubCategModel(
    photo: json["photo"],
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    category: Category.fromJson(json["category"]),
    product: List<dynamic>.from(json["product"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "id": id,
    "name": name,
    "photoName": photoName,
    "categoryId": categoryId,
    "category": category.toJson(),
    "product": List<dynamic>.from(product.map((x) => x)),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  int id;
  String name;
  List<SubCategory> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    subCategory: List<SubCategory>.from(json["subCategory"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
    required this.photoName,
    required this.categoryId,
    this.product,
  });

  int id;
  String name;
  String photoName;
  int categoryId;
  dynamic product;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photoName": photoName,
    "categoryId": categoryId,
    "product": product,
  };
}
