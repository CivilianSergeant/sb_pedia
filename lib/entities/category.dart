class Category{

  static const table = "faq_categories";

  final int id;
  final int parentId;
  final String name;
  final String alias;
  final String description;
  final int totalFaq;

  Category({this.id,this.parentId,this.name,this.alias,this.description,
  this.totalFaq});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: int.parse(json['id']),
      parentId: int.parse(json['parent_id']),
      name: json['name'],
      alias: json['alias'],
      description: json['description'],
      totalFaq: json['total_faq']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'parent_id' : parentId,
      'name' : name,
      'alias' : alias,
      'description' : description,
      'total_faq' : totalFaq
    };
  }
}