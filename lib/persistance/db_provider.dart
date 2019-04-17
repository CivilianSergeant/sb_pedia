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
          "id INT PRIMARY KEY,"
          "title TEXT,"
          "venue Text,"
          "start_date VARCHAR(10),"
          "start_time VARCHAR(10),"
          "end_date VARCHAR(10),"
          "end_time VARCHAR(10),"
          "event_code VARCHAR(50),"
          "event_schedule_id INT,"
          "city VARCHAR(50),"
          "image TEXT,"
          "content_url TEXT,"
          "type VARCHAR(20)"
          ")");
        await db.execute("CREATE TABLE news ("
          "id INT PRIMARY KEY,"
          "title TEXT,"
          "is_top_news TINYINT(1),"
          "approved_status VARCHAR(20),"
          "publish_date VARCHAR(10),"
          "image TEXT,"
          "type VARCHAR(20),"
          "description Text,"
          "content_url Text"
          ")");
        await db.execute("CREATE TABLE notifications ("
          "id INT PRIMARY KEY,"
          "title TEXT,"
          "message TEXT,"
          "is_top TINYINT(1),"
          "url TEXT,"
          "image_url TEXT,"
          "sent_date VARCHAR(10)"
          ")");
        await db.execute("CREATE TABLE settings ("
          "id INT PRIMARY KEY,"
          "title VARCHAR(50),"
          "status TINYINT(1)"
          ")");
        await db.execute("CREATE TABLE users ("
          "id INT PRIMARY KEY,"
          "username VARCHAR(100),"
          "password VARCHAR(100),"
          "user_type VARCHAR(10)"
          ")");
    });
  }

}