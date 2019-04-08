import 'package:flutter_demo/persistance/db_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_demo/entities/event.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EventService{

  static Future<dynamic> getEventsFromApi() async {

    try{
      final response = await http.get("http://sbes.socialbusinesspedia.com/api/sb_contents/content");
      final parsedJson = json.decode(response.body).cast<Map<String,dynamic>>();
      return parsedJson.map<Event>((json) => Event.fromJson(json)).toList();
    } on Exception catch(e){
      return null;
    }
  }

  static Future<void> addEvent(Event event) async {
    final Database db = await DbProvider.db.database;
    db.insert("events", event.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Event>> events () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query('events',orderBy: "start_date desc");

    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        title: maps[i]['title'],
        venue: maps[i]['venue'],
        startDate: maps[i]['start_date'],
        endDate: maps[i]['end_date']
      );
    });
  }
}