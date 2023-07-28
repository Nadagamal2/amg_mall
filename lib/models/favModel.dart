// To parse this JSON data, do
//
//     final favModel = favModelFromJson(jsonString);

import 'dart:convert';

FavModel favModelFromJson(String str) => FavModel.fromJson(json.decode(str));


class FavModel {
  FavModel({
    this.records,
    required this.newRecords,
    this.record,
    required this.code,
    required this.status,
    required this.message,
  });

  dynamic records;
  List<NewRecord> newRecords;
  dynamic record;
  String code;
  String status;
  String message;

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
    records: json["records"],
    newRecords: List<NewRecord>.from(json["newRecords"].map((x) => NewRecord.fromJson(x))),
    record: json["record"],
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );


}

class NewRecord {
  NewRecord({
    // this.photo,
    required this.id,
    required this.name,
    required this.price,
    required this.description,

    required this.overAll,
    // required this.tradeMark,
    // required this.originalProducts,
    // required this.customerService,
    // required this.paiementWhenRecieving,
    // required this.deliveryToAllGovernorates,
    // required this.returnOrderService,
    required this.photoName,
    // required this.specificationTitle1,
    // required this.specificationTitle2,
    // required this.specificationTitle3,
    // this.specificationTitle4,
    // required this.specificationDesc1,
    // required this.specificationDesc2,
    // required this.specificationDesc3,
    // this.specificationDesc4,
    // required this.subCategoryId,
    // this.subCategory,
    // required this.discountCodeId,
    // required this.discountCode,
    required this.productPhotos,
    required this.isFavorite,
    // required this.userFavoriteId,
    // this.userFavorite,
    // required this.applicationUserId,
    // this.applicationUser,
    this.productCount=0,
  });

  // dynamic photo;
  int id;
  String name;
  double price;
  String description;

  String overAll;
  // bool tradeMark;
  // bool originalProducts;
  // bool customerService;
  // bool paiementWhenRecieving;
  // bool deliveryToAllGovernorates;
  // bool returnOrderService;
  String photoName;
  // String specificationTitle1;
  // String specificationTitle2;
  // String specificationTitle3;
  // dynamic specificationTitle4;
  // String specificationDesc1;
  // String specificationDesc2;
  // String specificationDesc3;
  // dynamic specificationDesc4;
  // int subCategoryId;
  // dynamic subCategory;
  // int discountCodeId;
  // DiscountCode discountCode;
  List<ProductPhoto> productPhotos;
  bool isFavorite;
  int productCount;
  // int userFavoriteId;
  // dynamic userFavorite;
  // int applicationUserId;
  // dynamic applicationUser;

  factory NewRecord.fromJson(Map<String, dynamic> json) => NewRecord(
    // photo: json["photo"],
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],

    overAll: json["overAll"],
    // tradeMark: json["tradeMark"],
    // originalProducts: json["originalProducts"],
    // customerService: json["customerService"],
    // paiementWhenRecieving: json["paiementWhenRecieving"],
    // deliveryToAllGovernorates: json["deliveryToAllGovernorates"],
    // returnOrderService: json["returnOrderService"],
    photoName: json["photoName"],
    // specificationTitle1: json["specificationTitle1"],
    // specificationTitle2: json["specificationTitle2"],
    // specificationTitle3: json["specificationTitle3"],
    // specificationTitle4: json["specificationTitle4"],
    // specificationDesc1: json["specificationDesc1"],
    // specificationDesc2: json["specificationDesc2"],
    // specificationDesc3: json["specificationDesc3"],
    // specificationDesc4: json["specificationDesc4"],
    // subCategoryId: json["subCategoryId"],
    // subCategory: json["subCategory"],
    // discountCodeId: json["discountCodeId"],
    // discountCode: DiscountCode.fromJson(json["discountCode"]),
    productPhotos: List<ProductPhoto>.from(json["productPhotos"].map((x) => ProductPhoto.fromJson(x))),
    isFavorite: json["isFavorite"],
    // userFavoriteId: json["userFavoriteId"],
    // userFavorite: json["userFavorite"],
    // applicationUserId: json["applicationUserId"],
    // applicationUser: json["applicationUser"],
  );


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
