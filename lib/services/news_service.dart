import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sqflite/sqflite.dart';


class NewsService with NetworkService{

  static Future<void> addNews(News news) async {
    final Database db = await DbProvider.db.database;
    db.insert(News.table, news.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<News>> getNews () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(News.table,orderBy: "publish_date desc");

    return List.generate(maps.length, (i) {

      return News(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isTopNews: maps[i]['is_top_news'],
        image: maps[i]['image'],
        type: maps[i]['type'],
        approvedStatus: maps[i]['approved_status'],
        publishDate: maps[i]['publish_date'],
        description: maps[i]['description'],
        contentUrl: maps[i]['content_url']
      );
    });
  }

  static Future<News> getLatestNews() async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(News.table,where: 'is_top_news=?', whereArgs: [1], orderBy: "publish_date desc");
    return News.fromMap(maps.first);
  }

  @override
  T extractFromJson<T>(Map<String, dynamic> parsedJson) {
    try{
      if(parsedJson == null){
        return null;
      }
      var events = parsedJson[News.table].cast<Map<String,dynamic>>();
      return events.map<News>((json) => News.fromJson(json)).toList();
    } on Exception catch(e){
      return null;
    }
  }
}