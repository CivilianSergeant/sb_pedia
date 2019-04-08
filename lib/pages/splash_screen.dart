import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/colors/color_list.dart';
import 'package:flutter_demo/entities/event.dart';
import 'package:flutter_demo/services/event_service.dart';

class SplashScreen extends StatefulWidget{
  @override
  State createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  startTime() async {
    var _duration = new Duration(seconds: 3);
    dynamic events = await EventService.events();
    if(events == null || events.length == 0) {
      EventService.getEventsFromApi().then((dynamic lists) {
        if (lists != null) {
          lists.forEach((Event element) =>
            EventService.addEvent(element)
          );
        }

      });
    }
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("splash"),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(

            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5,0.9],
              colors: [
                ColorList.greenColor,
                ColorList.greenAccentColor
              ]
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
}