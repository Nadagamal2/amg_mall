class Questions{
  int? id;
  String? question;
  String? answer;

  Questions({this.id, this.question, this.answer,});


  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],


    );
  }



}