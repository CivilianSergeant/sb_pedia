class User{

  static const table = "users";
  static const GUEST = "guest";
  static const REGISTERED = "registered";

  final int id;
  final String username;
  final String password;
  final String userType;

  User({this.id,this.username,this.password,this.userType});

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      userType: map['user_type']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'username': username,
      'password': password,
      'user_type': userType
    };
  }


}