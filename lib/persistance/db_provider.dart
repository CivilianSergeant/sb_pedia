import 'package:flutter_demo/entities/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider{
  DbProvider._();
  static final DbProvider db = DbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "app_session.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {
        },
        onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE events ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT,"
          "start_date TEXT,"
          "start_time TEXT,"
          "end_date TEXT,"
          "end_time TEXT,"
          "venue Text"
          ")");
    });
  }

}