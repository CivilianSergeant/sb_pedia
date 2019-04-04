import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entities/event.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EventService{
  static Future<dynamic> getEvents() async {

    try{

      final response = await http.get("http://sbes.socialbusinesspedia.com/api/sb_contents/content");
      final parsedJson = json.decode(response.body).cast<Map<String,dynamic>>();
      return parsedJson.map<Event>((json) => Event.fromJson(json)).toList();
    } on Exception catch(e){
      print("HERE");
      return null;
    }
  }
}