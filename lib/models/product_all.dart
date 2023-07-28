// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.features,
    required this.overAll,
    required this.tradeMark,
    required this.originalProducts,
    required this.customerService,
    required this.paiementWhenRecieving,
    required this.deliveryToAllGovernorates,
    required this.returnOrderService,
    required this.photoName,
    required this.specificationTitle1,
    required this.specificationTitle2,
    this.specificationTitle3,
    this.specificationTitle4,
    required this.specificationDesc1,
    required this.specificationDesc2,
    this.specificationDesc3,
    this.specificationDesc4,
    required this.subCategoryId,
    required this.subCategory,
    required this.discountCodeId,
    this.discountCode,
    required this.productPhotos,
  });

  int id;
  String name;
  double price;
  String description;
  String features;
  String overAll;
  bool tradeMark;
  bool originalProducts;
  bool customerService;
  bool paiementWhenRecieving;
  bool deliveryToAllGovernorates;
  bool returnOrderService;
  String photoName;
  String specificationTitle1;
  String specificationTitle2;
  String? specificationTitle3;
  dynamic specificationTitle4;
  String specificationDesc1;
  String specificationDesc2;
  String? specificationDesc3;
  dynamic specificationDesc4;
  int subCategoryId;
  SubCategory subCategory;
  int discountCodeId;
  dynamic discountCode;
  List<ProductPhoto> productPhotos;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    features: json["features"],
    overAll: json["overAll"],
    tradeMark: json["tradeMark"],
    originalProducts: json["originalProducts"],
    customerService: json["customerService"],
    paiementWhenRecieving: json["paiementWhenRecieving"],
    deliveryToAllGovernorates: json["deliveryToAllGovernorates"],
    returnOrderService: json["returnOrderService"],
    photoName: json["photoName"],
    specificationTitle1: json["specificationTitle1"],
    specificationTitle2: json["specificationTitle2"],
    specificationTitle3: json["specificationTitle3"],
    specificationTitle4: json["specificationTitle4"],
    specificationDesc1: json["specificationDesc1"],
    specificationDesc2: json["specificationDesc2"],
    specificationDesc3: json["specificationDesc3"],
    specificationDesc4: json["specificationDesc4"],
    subCategoryId: json["subCategoryId"],
    subCategory: SubCategory.fromJson(json["subCategory"]),
    discountCodeId: json["discountCodeId"],
    discountCode: json["discountCode"],
    productPhotos: List<ProductPhoto>.from(json["productPhotos"].map((x) => ProductPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "features": features,
    "overAll": overAll,
    "tradeMark": tradeMark,
    "originalProducts": originalProducts,
    "customerService": customerService,
    "paiementWhenRecieving": paiementWhenRecieving,
    "deliveryToAllGovernorates": deliveryToAllGovernorates,
    "returnOrderService": returnOrderService,
    "photoName": photoName,
    "specificationTitle1": specificationTitle1,
    "specificationTitle2": specificationTitle2,
    "specificationTitle3": specificationTitle3,
    "specificationTitle4": specificationTitle4,
    "specificationDesc1": specificationDesc1,
    "specificationDesc2": specificationDesc2,
    "specificationDesc3": specificationDesc3,
    "specificationDesc4": specificationDesc4,
    "subCategoryId": subCategoryId,
    "subCategory": subCategory.toJson(),
    "discountCodeId": discountCodeId,
    "discountCode": discountCode,
    "productPhotos": List<dynamic>.from(productPhotos.map((x) => x.toJson())),
  };
}

class ProductPhoto {
  ProductPhoto({
    required this.id,
    required this.imgUrl,
    required this.productId,
  });

  int id;
  String imgUrl;
  int productId;

  factory ProductPhoto.fromJson(Map<String, dynamic> json) => ProductPhoto(
    id: json["id"],
    imgUrl: json["imgURL"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imgURL": imgUrl,
    "productId": productId,
  };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
    required this.photoName,
    required this.categoryId,
    this.category,
    required this.product,
  });

  int id;
  String name;
  String photoName;
  int categoryId;
  dynamic category;
  List<dynamic> product;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    category: json["category"],
    product: List<dynamic>.from(json["product"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photoName": photoName,
    "categoryId": categoryId,
    "category": category,
    "product": List<dynamic>.from(product.map((x) => x)),
  };
}
