import 'package:social_business/entities/event.dart';
import 'package:social_business/entities/news.dart';
import 'package:social_business/entities/notification.dart';
import 'package:social_business/entities/setting.dart';
import 'package:social_business/persistance/db_provider.dart';
import 'package:social_business/services/event_service.dart';
import 'package:social_business/services/news_service.dart';
import 'package:social_business/services/notification_service.dart';
import 'package:sqflite/sqlite_api.dart';

class SettingsService{
  static Future<void> addSetting(Setting setting) async {
    final Database db = await DbProvider.db.database;
    db.insert(Setting.table, setting.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateSetting(Setting setting) async{
    final Database db = await DbProvider.db.database;
    return await db.update(Setting.table, setting.toMap(),where: "id=?",whereArgs: [setting.id]);
  }

  static Future<List<Setting>> getSettings () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(Setting.table);

    return List.generate(maps.length, (i) {
      return Setting(
        id: maps[i]['id'],
        title: maps[i]['title'],
        status: (maps[i]['status']>0)? true : false
      );
    });
  }

  static void refreshAndLoadData(dynamic parsedJson){
    List<Event> events = EventService().extractFromJson<List<Event>>(parsedJson);
    if (events != null) {
      events.forEach((Event event) => EventService.addEvent(event));
    }

    List<News> allNews = NewsService().extractFromJson<List<News>>(parsedJson);
    if(allNews != null){
      allNews.forEach((News news) => NewsService.addNews(news));
    }

    List<Notification> allNotifications = NotificationService()
        .extractFromJson<List<Notification>>(parsedJson);
    if(allNotifications != null){
      allNotifications.forEach((Notification notification) =>
          NotificationService.addNotification(notification));
    }
  }

  static void loadInitialSettings(){
    SettingsService.addSetting(Setting(id: 1,status: true,title: "Event Notification"));
    SettingsService.addSetting(Setting(id: 2,status: true,title: "News Notification"));
  }
}