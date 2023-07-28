class ProductSubCategHomeModel {
  Null? photo;
  int? id;
  String? name;
  var price;
  String? description;
  String? overAll;

  String? photoName;

  SubCategory? subCategory;
  List<ProductPhotos>? productPhotos;
  bool? isFavorite;



  ProductSubCategHomeModel(
      {this.photo,
        this.id,
        this.name,
        this.price,
        this.description,
        this.overAll,

        this.photoName,

        this.subCategory,
        this.productPhotos,
        this.isFavorite,
    });

  ProductSubCategHomeModel.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    overAll = json['overAll'];

    photoName = json['photoName'];

     subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    if (json['productPhotos'] != null) {
      productPhotos = <ProductPhotos>[];
      json['productPhotos'].forEach((v) {
        productPhotos!.add(new ProductPhotos.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'];



  }


}

class SubCategory {
  int? id;
  String? name;
  String? photoName;
  int? categoryId;
  Null? category;
  List<Product>? product;

  SubCategory(
      {this.id,
        this.name,
        this.photoName,
        this.categoryId,
        this.category,
        this.product});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoName = json['photoName'];
    categoryId = json['categoryId'];
    category = json['category'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }


}

class Product {
  int? id;
  String? name;
  double? price;
  String? description;
  String? overAll;
  bool? tradeMark;
  bool? originalProducts;
  bool? customerService;
  bool? paiementWhenRecieving;
  bool? deliveryToAllGovernorates;
  bool? returnOrderService;
  String? photoName;
  String? specificationTitle1;
  String? specificationTitle2;
  String? specificationTitle3;
  Null? specificationTitle4;
  String? specificationDesc1;
  String? specificationDesc2;
  String? specificationDesc3;
  Null? specificationDesc4;
  int? subCategoryId;
  List<ProductPhotos>? productPhotos;
  bool? isFavorite;
  int? userFavoriteId;
  Null? userFavorite;
  int? applicationUserId;
  Null? applicationUser;
  int? finalPrice;

  Product(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.overAll,
        this.tradeMark,
        this.originalProducts,
        this.customerService,
        this.paiementWhenRecieving,
        this.deliveryToAllGovernorates,
        this.returnOrderService,
        this.photoName,
        this.specificationTitle1,
        this.specificationTitle2,
        this.specificationTitle3,
        this.specificationTitle4,
        this.specificationDesc1,
        this.specificationDesc2,
        this.specificationDesc3,
        this.specificationDesc4,
        this.subCategoryId,
        this.productPhotos,
        this.isFavorite,
        this.userFavoriteId,
        this.userFavorite,
        this.applicationUserId,
        this.applicationUser,
        this.finalPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    overAll = json['overAll'];
    tradeMark = json['tradeMark'];
    originalProducts = json['originalProducts'];
    customerService = json['customerService'];
    paiementWhenRecieving = json['paiementWhenRecieving'];
    deliveryToAllGovernorates = json['deliveryToAllGovernorates'];
    returnOrderService = json['returnOrderService'];
    photoName = json['photoName'];
    specificationTitle1 = json['specificationTitle1'];
    specificationTitle2 = json['specificationTitle2'];
    specificationTitle3 = json['specificationTitle3'];
    specificationTitle4 = json['specificationTitle4'];
    specificationDesc1 = json['specificationDesc1'];
    specificationDesc2 = json['specificationDesc2'];
    specificationDesc3 = json['specificationDesc3'];
    specificationDesc4 = json['specificationDesc4'];
    subCategoryId = json['subCategoryId'];
    if (json['productPhotos'] != null) {
      productPhotos = <ProductPhotos>[];
      json['productPhotos'].forEach((v) {
        productPhotos!.add(new ProductPhotos.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'];
    userFavoriteId = json['userFavoriteId'];
    userFavorite = json['userFavorite'];
    applicationUserId = json['applicationUserId'];
    applicationUser = json['applicationUser'];
    finalPrice = json['finalPrice'];
  }


}

class ProductPhotos {
  int? id;
  String? imgURL;
  int? productId;

  ProductPhotos({this.id, this.imgURL, this.productId});

  ProductPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgURL = json['imgURL'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgURL'] = this.imgURL;
    data['productId'] = this.productId;
    return data;
  }
}


