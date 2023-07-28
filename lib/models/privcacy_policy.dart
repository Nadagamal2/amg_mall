class PrivacyPolicy{
  int? id;
  String? details;

  PrivacyPolicy({this.id, this.details});


  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicy(
      id: json['id'],
      details: json['details'],


    );
  }



}