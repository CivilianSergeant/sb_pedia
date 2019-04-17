import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

abstract class NetworkService{

  static Future<Map<String,dynamic>> fetch(String url) async {
    try{
      final response = await http.get(url);
      final parsedJson = jsonDecode(response.body);
      return parsedJson;
    } on Exception catch(e){
      return null;
    }
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  T extractFromJson<T>(Map<String,dynamic> parsedJson);
}