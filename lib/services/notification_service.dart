import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sb_pedia/entities/notification.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sqflite/sqflite.dart';


class NotificationService with NetworkService{

  static Future<void> addNotification(Notification news,{bool welcome}) async {
    if(welcome){
      news.ID = 1;
    }
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
    final List<Map<String, dynamic>> maps = await db.query(Notification.table, where:"is_top=?",whereArgs:[1],orderBy: "id desc");
    if(maps.length>0) {
      return Notification.fromMap(maps.first);
    }
    return null;
  }

  static Future<void> raiseLocalNotification(Map<String,dynamic> message, Function launchScreenHandler) async {
    var _androidInitSettings = AndroidInitializationSettings('notification');
    var _iosInitSettings = IOSInitializationSettings();
    var _initializationSettings = InitializationSettings(_androidInitSettings,
        _iosInitSettings);
    final _flutterLocalNotification = FlutterLocalNotificationsPlugin();
    _flutterLocalNotification.initialize(_initializationSettings,
        onSelectNotification: launchScreenHandler);
    var _androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'sb_pedia_local_notification',
        'sb_pedia_local_notification',
        'this will be sb_pedia local notification',
        playSound: true
    );
    var _iosPlatformChannelSpecifics =  IOSNotificationDetails();
    var _platformSpecifics = NotificationDetails(_androidPlatformChannelSpecifics,
        _iosPlatformChannelSpecifics);
    await _flutterLocalNotification.show(0, message['notification']['title'],message['notification']['body'],
        _platformSpecifics,payload: json.encode(message));


    addNotification(Notification.fromMap({
      'is_top': message['data']['is_top'],
      'title' : message['notification']['title'],
      'message' : message['notification']['body'],
      'url' : message['data']['content_url']
    }),welcome: ((message['data']!= null
        && message['data']['isWelcome'] != null)?
          message['data']['isWelcome'] :false));
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