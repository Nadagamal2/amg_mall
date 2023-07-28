class CategModel{
  int? id;
  String? name;


  CategModel({this.id, this.name,  });


  factory CategModel.fromJson(Map<String, dynamic> json) {
    return CategModel(
      id: json['id'],
       name: json['name'],


    );
  }



}