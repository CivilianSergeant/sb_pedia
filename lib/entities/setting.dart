class Setting{
  static const table = "settings";

  final int id;
  final String title;
  final String description;
  final String alias;
  bool status;

  void set Status (bool v)=> this.status = v;

  Setting({this.id,this.title,this.status,this.description,this.alias});

  factory Setting.fromMap(Map<String,dynamic> map){
    return Setting(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      alias: map['alias'],
      status: ((map['status']>0)? true : false)
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'alias': alias,
      'status': (status)? 1 : 0
    };
  }
}