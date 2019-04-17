class News{

  static const table = "news";

  final int id;
  final int isTopNews;
  final String approvedStatus;
  final String publishDate;
  final String description;
  final String contentUrl;
  final String title;
  final String image;
  final String type;

  News({
    this.id,
    this.isTopNews,
    this.approvedStatus,
    this.publishDate,
    this.title,
    this.image,
    this.type,
    this.description,
    this.contentUrl
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: int.parse(json['id']),
        title: json['title'],
        isTopNews: int.parse(json['is_top_news']),
        publishDate: json['publish_date'],
        approvedStatus: json['approved_status'],
        image: json['image'],
        type: json['type'],
        description: json['description'],
        contentUrl: json['content_url']
    );
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
        id: map['id'],
        title: map['title'],
        isTopNews: map['is_top_news'],
        publishDate: map['publish_date'],
        approvedStatus: map['approved_status'],
        image: map['image'],
        type: map['type'],
        description: map['description'],
        contentUrl: map['content_url']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'is_top_news': isTopNews,
      'publish_date': publishDate,
      'approved_status': approvedStatus,
      'image' : image,
      'type' : type,
      'description': description,
      'content_url' : contentUrl
    };
  }
}