class TermsAndConditions{
  int? id;
  String? details;

  TermsAndConditions({this.id, this.details});


  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      id: json['id'],
      details: json['details'],


    );
  }



}