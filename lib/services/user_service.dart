import 'package:sb_pedia/entities/user.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sqflite/sqflite.dart';


class UserService{
  static Future<void> addUser(User user) async {
    final Database db = await DbProvider.db.database;
    db.insert(User.table, user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<User> getUser () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(User.table);
    if(maps.length>0) {
      Map<String, dynamic> user = maps.first;

      return User(
        id: user['id'],
        username: user['username'],
        password: user['password'],
        userType: user['user_type'],
        email: user['email'],
        firstName: user['first_name'],
        lastName: user['last_name'],
        profileImage: user['profile_image']
      );
    }else{
      return User();
    }
  }
}