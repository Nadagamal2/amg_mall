

import 'dart:convert';

List<SupcatModel> supcatModelFromJson(String str) => List<SupcatModel>.from(json.decode(str).map((x) => SupcatModel.fromJson(x)));


class Category {
  Category({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  int id;
  String name;
  List<SupcatModel> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    subCategory: List<SupcatModel>.from(json["subCategory"].map((x) => SupcatModel.fromJson(x))),
  );


}

class SupcatModel {
  SupcatModel({
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

  factory SupcatModel.fromJson(Map<String, dynamic> json) => SupcatModel(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    product: json["product"],
  );


}
