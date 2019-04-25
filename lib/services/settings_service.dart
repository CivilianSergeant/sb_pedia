import 'package:sb_pedia/entities/category.dart';
import 'package:sb_pedia/entities/event.dart';
import 'package:sb_pedia/entities/faq.dart';
import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/entities/notification.dart';
import 'package:sb_pedia/entities/setting.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/category_service.dart';
import 'package:sb_pedia/services/event_service.dart';
import 'package:sb_pedia/services/faq_service.dart';
import 'package:sb_pedia/services/news_service.dart';
import 'package:sb_pedia/services/notification_service.dart';
import 'package:sqflite/sqflite.dart';


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
    // Get Events Data
    List<Event> events = EventService().extractFromJson<List<Event>>(parsedJson);
    if (events != null) {
      events.forEach((Event event) => EventService.addEvent(event));
    }

    // Get News Data
    List<News> allNews = NewsService().extractFromJson<List<News>>(parsedJson);
    if(allNews != null){
      allNews.forEach((News news) => NewsService.addNews(news));
    }

    // Get Notification Data
    List<Notification> allNotifications = NotificationService()
        .extractFromJson<List<Notification>>(parsedJson);
    if(allNotifications != null){
      allNotifications.forEach((Notification notification) =>
          NotificationService.addNotification(notification));
    }

    // Get Categories Data
    List<Category> allCategories = CategoryService()
        .extractFromJson<List<Category>>(parsedJson);
    if(allCategories != null){
      allCategories.forEach((Category category){
        CategoryService.addCategory(category);
      });
    }

    // Get Faqs Data
    List<Faq> allFaqs = FaqService().extractFromJson<List<Faq>>(parsedJson);

    if(allFaqs != null){
      allFaqs.forEach((Faq faq){
        FaqService.addCategory(faq);
      });
    }

  }

  static void loadInitialSettings(){
    SettingsService.addSetting(Setting(id: 1,status: true,title: "Event Notification"));
    SettingsService.addSetting(Setting(id: 2,status: true,title: "News Notification"));
  }
}