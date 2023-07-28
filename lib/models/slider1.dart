class Slider1{
  int? id;
  String? photoName;


  Slider1({this.id, this.photoName,});


  factory Slider1.fromJson(Map<String, dynamic> json) {
    return Slider1(
      id: json['id'],
      photoName: json['photoName'],



    );
  }



}