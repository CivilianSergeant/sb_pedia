import 'package:social_business/persistance/db_provider.dart';
import 'package:social_business/services/network_service.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:social_business/entities/event.dart';
import 'dart:async';

class EventService with NetworkService{

  static Future<void> addEvent(Event event) async {
    final Database db = await DbProvider.db.database;
    db.insert(Event.table, event.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Event>> getEvents () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query('events',orderBy: "start_date desc");

    return List.generate(maps.length, (i) {

      return Event(
        id: maps[i]['id'],
        title: maps[i]['title'],
        venue: maps[i]['venue'],
        startDate: maps[i]['start_date'],
        startTime: maps[i]['start_time'],
        endDate: maps[i]['end_date'],
        contentUrl: maps[i]['content_url'],
        image: maps[i]['image'],
      );
    });
  }

  @override
  T extractFromJson<T>(Map<String, dynamic> parsedJson) {
    try{
        if(parsedJson == null){
          return null;
        }
        var events = parsedJson[Event.table].cast<Map<String,dynamic>>();
        return events.map<Event>((json) => Event.fromJson(json)).toList();
    } on Exception catch(e){
      return null;
    }
  }
}