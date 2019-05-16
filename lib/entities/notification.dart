class Notification{

  static const table = "notifications";

  int id;
  final int isTop;
  final String title;
  final String message;
  final String url;
  final String imageUrl;
  final String sentDate;

  set ID (int _id)=> id = _id;

  Notification({this.id,this.isTop,this.title,this.message,this.url,this.imageUrl,this.sentDate});

  factory Notification.fromJson(Map<String,dynamic> json){
    return Notification(
      id : int.parse(json['id']),
      isTop: int.parse(json['is_top']),
      title: json['title'],
      message: json['message'],
      url : json['url'],
      imageUrl: json['image_url'],
      sentDate: json['sent_date']
    );
  }

  factory Notification.fromMap(Map<String,dynamic> map){
    return Notification(
        id : map['id'],
        isTop: int.parse(map['is_top'].toString()),
        title: map['title'],
        message: map['message'],
        url : map['url'],
        imageUrl: map['image_url'],
        sentDate: map['sent_date']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'is_top' : isTop,
      'title' : title,
      'message' : message,
      'url' : url,
      'image_url' : imageUrl,
      'sent_date' : sentDate
    };
  }
}