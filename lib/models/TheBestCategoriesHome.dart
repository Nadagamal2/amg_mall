class TheBestCategoriesHome{
  int? id;
  String? name;
  String? photoName;

  TheBestCategoriesHome({this.id, this.name, this.photoName,});


  factory TheBestCategoriesHome.fromJson(Map<String, dynamic> json) {
    return TheBestCategoriesHome(
      id: json['id'],
      name: json['name'],
      photoName: json['photoName'],


    );
  }



}