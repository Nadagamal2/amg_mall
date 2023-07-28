class GetOrderModel {

  int? count;
  List<Data>? data;


  GetOrderModel(
      {
        this.count,
        this.data,
       });

  GetOrderModel.fromJson(Map<String, dynamic> json) {


    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }

  }


}

class Data {
  int? id;
  int? productId;
  Product? product;
  String? applicationUserId;
  Null? applicationUser;
  String? sevedDate;
  double? price;
  int? quantity;
  String? status;

  Data(
      {this.id,
        this.productId,
        this.product,
        this.applicationUserId,
        this.applicationUser,
        this.sevedDate,
        this.price,
        this.quantity=1,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    applicationUserId = json['applicationUserId'];
    applicationUser = json['applicationUser'];
    sevedDate = json['sevedDate'];
    price = json['price'];
    quantity = json['quantity'];
    status = json['status'];
  }


}

class Product {
  int? id;
  String? name;
  double? price;
  String? description;
  String? features;
  String? overAll;

  String? photoName;


  Product(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.features,
        this.overAll,

        this.photoName,
       });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    features = json['features'];
    overAll = json['overAll'];

    photoName = json['photoName'];

  }


}