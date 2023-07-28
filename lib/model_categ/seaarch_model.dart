// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.records,
    required this.code,
    required this.message,
    required this.status,
  });

  List<Record> records;
  String code;
  String message;
  String status;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    code: json["code"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
    "code": code,
    "message": message,
    "status": status,
  };
}

class Record {
  Record({
    this.photo,
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
    required this.specificationTitle3,
    this.specificationTitle4,
    required this.specificationDesc1,
    required this.specificationDesc2,
    required this.specificationDesc3,
    this.specificationDesc4,
    required this.subCategoryId,
    required this.subCategory,
    this.discountCodeId,
    this.discountCode,
    required this.productPhotos,
    required this.isFavorite,
    required this.userFavoriteId,
    required this.userFavorite,
    required this.applicationUserId,
    this.applicationUser,
  });

  dynamic photo;
  int id;
  String name;
  int price;
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
  String specificationTitle3;
  dynamic specificationTitle4;
  String specificationDesc1;
  String specificationDesc2;
  String specificationDesc3;
  dynamic specificationDesc4;
  int subCategoryId;
  SubCategory subCategory;
  dynamic discountCodeId;
  dynamic discountCode;
  List<ProductPhoto> productPhotos;
  bool isFavorite;
  int userFavoriteId;
  List<UserFavorite> userFavorite;
  int applicationUserId;
  dynamic applicationUser;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    photo: json["photo"],
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
    isFavorite: json["isFavorite"],
    userFavoriteId: json["userFavoriteId"],
    userFavorite: List<UserFavorite>.from(json["userFavorite"].map((x) => UserFavorite.fromJson(x))),
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
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
    "isFavorite": isFavorite,
    "userFavoriteId": userFavoriteId,
    "userFavorite": List<dynamic>.from(userFavorite.map((x) => x.toJson())),
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
  };
}

class ProductPhoto {
  ProductPhoto({
    required this.id,
    required this.imgUrl,
    required this.productId,
    this.product,
  });

  int id;
  String imgUrl;
  int productId;
  dynamic product;

  factory ProductPhoto.fromJson(Map<String, dynamic> json) => ProductPhoto(
    id: json["id"],
    imgUrl: json["imgURL"],
    productId: json["productId"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imgURL": imgUrl,
    "productId": productId,
    "product": product,
  };
}

class SubCategory {
  SubCategory({
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
  dynamic category;
  dynamic product;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    categoryId: json["categoryId"],
    category: json["category"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photoName": photoName,
    "categoryId": categoryId,
    "category": category,
    "product": product,
  };
}

class UserFavorite {
  UserFavorite({
    required this.id,
    required this.applicationUserId,
    this.applicationUser,
    required this.productId,
    this.product,
  });

  int id;
  String applicationUserId;
  dynamic applicationUser;
  int productId;
  dynamic product;

  factory UserFavorite.fromJson(Map<String, dynamic> json) => UserFavorite(
    id: json["id"],
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    productId: json["productId"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "productId": productId,
    "product": product,
  };
}
