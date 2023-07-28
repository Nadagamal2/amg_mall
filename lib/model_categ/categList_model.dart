class OrderRecord {
  int? id;
  int? productId;
  Product? product;
  String? applicationUserId;
  dynamic quantity;
  dynamic totalPriceOfProduct;

  OrderRecord(
      {this.id,
      this.productId,
      this.product,
      this.applicationUserId,
      this.quantity,
      this.totalPriceOfProduct});

  OrderRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    applicationUserId = json['applicationUserId'];
    quantity = json['quantity'];
    totalPriceOfProduct = json['totalPriceOfProduct'];
  }
}

class Product {
  int? id;
  String? name;
  dynamic  price;
  String? description;
  String? overAll;

  String? photoName;


  Null? productPhotos;
  bool? isFavorite;



  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.overAll,

      this.photoName,

      this.productPhotos,
      this.isFavorite,

     });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    overAll = json['overAll'];


    photoName = json['photoName'];


    productPhotos = json['productPhotos'];
    isFavorite = json['isFavorite'];


  }
}
