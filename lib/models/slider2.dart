class Slider2{
  int? id;
  String? photoName;


  Slider2({this.id, this.photoName,});


  factory Slider2.fromJson(Map<String, dynamic> json) {
    return Slider2(
      id: json['id'],
      photoName: json['photoName'],



    );
  }



}