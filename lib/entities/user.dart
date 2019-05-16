class User{

  static const table = "users";
  static const GUEST = "guest";
  static const REGISTERED = "registered";

  int id;
  final String username;
  final String password;
  final String userType;
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  User({this.id,this.username,
    this.password,this.userType,
    this.email,this.firstName,
    this.lastName,this.profileImage
  });

  void set ID (int _id) => this.id = _id;

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      userType: map['user_type'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      profileImage: map['profile_image']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'username': username,
      'password': password,
      'user_type': userType,
      'email' : email,
      'first_name' : firstName,
      'last_name' : lastName,
      'profile_image' : profileImage
    };
  }


}