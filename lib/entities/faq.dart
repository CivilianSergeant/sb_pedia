import 'dart:convert';

class Faq{
  static const table = "faqs";

  final int id;
  final String question;
  final String answer;
  final String tags;
  final String categories;

  Faq({this.id,this.question,this.answer,this.tags,this.categories});

  factory Faq.fromJson(Map<String,dynamic> json){
    return Faq(
      id: int.parse(json['id']),
      question: json['question'],
      answer: json['answer'],
      tags: json['tags'],
      categories: jsonEncode(json['categories'])
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'question' : question,
      'answer' : answer,
      'tags' : tags,
      'categories' : categories
    };
  }
}