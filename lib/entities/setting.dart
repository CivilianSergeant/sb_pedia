class Setting{
  static const table = "settings";

  final int id;
  final String title;
  bool status;

  void set Status (bool v)=> this.status = v;

  Setting({this.id,this.title,this.status});

  factory Setting.fromMap(Map<String,dynamic> map){
    return Setting(
      id: map['id'],
      title: map['title'],
      status: ((map['status']>0)? true : false)
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'status': (status)? 1 : 0
    };
  }
}