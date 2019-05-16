import 'package:imei_plugin/imei_plugin.dart';
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
        description: maps[i]['description'],
        alias:maps[i]['alias'],
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

  static Future<String> getImei() async{
    var imei = await ImeiPlugin.getImei;
    return imei;
  }

  static void loadInitialSettings(){
    SettingsService.addSetting(Setting(id: 1,status: true,title: "SB News",
    description: "what are going on the world about Social Business , you will get  those News  notification If you check on this",
    alias: 'news'));

    SettingsService.addSetting(Setting(id: 2,status: true,title: "SB Event",
    description: "SB event such SBD, GSBS, SBAC  notification will send to you if you check on this.",
    alias: 'event'));

    SettingsService.addSetting(Setting(id: 3,status: true,title: "SBAC",
    description: "Notification regarding Social Business Academia Conference",
    alias: 'sbac'));

    SettingsService.addSetting(Setting(id: 4, status: true, title: "YSBC",
    description: "Notification regarding Yunus Social Business Centre",
    alias: 'ysbc'));
    
    SettingsService.addSetting(Setting(id:5, status: true, title: "General",
    description: "General Notification regarding Social Business",
    alias: 'general'));
  }
}