// To parse this JSON data, do
//
//     final subCategHomeModel = subCategHomeModelFromJson(jsonString);

import 'dart:convert';

List<SubCategHomeModel> subCategHomeModelFromJson(String str) => List<SubCategHomeModel>.from(json.decode(str).map((x) => SubCategHomeModel.fromJson(x)));

String subCategHomeModelToJson(List<SubCategHomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  int id;
  String name;
  List<SubCategHomeModel> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    subCategory: List<SubCategHomeModel>.from(json["subCategory"].map((x) => SubCategHomeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategHomeModel {
  SubCategHomeModel({
    required this.id,
    required this.name,
    required this.photoName,
    required this.categoryId,
    this.category,
    this.product,
  });

  int id;
  String name;
  String photoName;
  int categoryId;
  Category? category;
  dynamic product;

  factory SubCategHomeModel.fromJson(Map<String, dynamic> json) => SubCategHomeModel(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photoName": photoName,
    "categoryId": categoryId,
    "category": category?.toJson(),
    "product": product,
  };
}
