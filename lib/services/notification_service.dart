import 'package:sb_pedia/entities/notification.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sqflite/sqflite.dart';


class NotificationService with NetworkService{

  static Future<void> addNotification(Notification news) async {
    final Database db = await DbProvider.db.database;
    db.insert(Notification.table, news.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Notification>> getNotifications () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(Notification.table,orderBy: "sent_date desc");

    return List.generate(maps.length, (i) {

      return Notification(
        id: maps[i]['id'],
        isTop: maps[i]['is_top'],
        title: maps[i]['title'],
        message: maps[i]['message'],
        url : maps[i]['url'],
        imageUrl: maps[i]['image_url'],
        sentDate: maps[i]['sent_date']
      );
    });
  }

  static Future<Notification> getLatestNotification() async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(Notification.table,orderBy: "sent_date desc");
    return Notification.fromMap(maps.first);
  }

  @override
  T extractFromJson<T>(Map<String, dynamic> parsedJson) {
    try{
      if(parsedJson == null){
        return null;
      }
      var events = parsedJson[Notification.table].cast<Map<String,dynamic>>();
      return events.map<Notification>((json) => Notification.fromJson(json)).toList();
    } on Exception catch(e){
      return null;
    }
  }
}