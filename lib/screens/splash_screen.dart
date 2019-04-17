import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_business/entities/event.dart';
import 'package:social_business/entities/news.dart';
import 'package:social_business/entities/notification.dart' as SBNotification;
import 'package:social_business/entities/setting.dart';
import 'package:social_business/entities/user.dart';
import 'package:social_business/services/event_service.dart';
import 'package:social_business/services/network_service.dart';
import 'package:social_business/services/news_service.dart';
import 'package:social_business/services/notification_service.dart';
import 'package:social_business/services/settings_service.dart';
import 'package:social_business/services/user_service.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:toast/toast.dart';

class SplashScreen extends StatefulWidget{
  @override
  State createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  startTime(){
    var _duration = new Duration(seconds: 5);

    UserService.getUser().then((User user) async{
      if(user != null && user.id != null){
        Navigator.of(context).pushReplacementNamed('/home');
      }else{
        String url = "http://sbes.socialbusinesspedia.com/api/sb_contents/content";
        final parsedJson = await NetworkService.fetch(url);

        if(parsedJson==null){
          Toast.show("Internet not available",context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER);
          return new Timer(_duration, startTime);
        }
        SettingsService.refreshAndLoadData(parsedJson);
        SettingsService.loadInitialSettings();
        navigationPage();
      }
    });
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("splash"),
      body:  Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorList.greenAccentColor,
            image: new DecorationImage(
              image: new AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            )
          ),
        child: Column(

          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 60),
            child: SizedBox(
              width: 128,
              height: 128,
              child: Image(
                image: AssetImage("images/ic_launcher_512_n.png"),
              ),
            ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: CircularProgressIndicator() ,
            )
          ],
        ),
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
}