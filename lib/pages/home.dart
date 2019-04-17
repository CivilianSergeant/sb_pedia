import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/app_bar/app_bar.dart';
import 'package:flutter_demo/colors/color_list.dart';
import 'package:flutter_demo/grid_view/grid_item.dart';
import 'package:flutter_demo/navigation_drawer/navigation_drawer.dart';
import 'package:flutter_demo/icons/my_flutter_icons.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return HomePageWidget();
  }
}

class HomePageWidget extends StatefulWidget{

  @override
  HomePageWidgetState createState() => new HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget>{

  Color greenColor = ColorList.greenColor;
  Color greenAccentColor = ColorList.greenAccentColor;
  AppLifecycleState state;
  var androidMessageChannel = MethodChannel("android_app_retain");
  static int backButtonState = 0;

  void triggerAction (BuildContext context,String actionName){

    switch(actionName){
      case "events":
        Navigator.pushReplacementNamed(context, '/events');
        break;
      case "news":
        Navigator.pushReplacementNamed(context, '/news');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Do you want to exit this application?'),
          content: new Text('We hate to see you leave...'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () => exit(0),
              child: new Text('Yes'),
            ),
          ],
        );
      }
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var appTitleBar = AppTitleBar(backgroundColor: ColorList.greenColor);

    return  WillPopScope(
      onWillPop: () async {
        if(Navigator.canPop(context)){
          return Future.value(true);
        }else{
          if (Platform.isAndroid) {
            androidMessageChannel.invokeMethod("sendAppToBackground");
          }else{
            _exitApp(context);
          }
        }
      },
      child: Scaffold(
        key: Key("home"),
        appBar: appTitleBar.build(state: widget),
        drawer: NavigationDrawer(color: greenColor,accentColor: greenAccentColor,imagePath: IMAGE_URL,),
        body: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(8),
          children: <Widget>[
            GridItem(callback:this.triggerAction, name: 'events',color: greenAccentColor, text:"SB Event", icon: MyFlutter.calendar,),
            GridItem(color: greenAccentColor, text:"SBAC", icon: MyFlutter.chart_line,),
            GridItem(color: greenAccentColor, text:"SB World", icon: Icons.public,),
            GridItem(color: greenAccentColor, text:"SB Design Lab", icon:MyFlutter.chart_pie),
            GridItem(callback:this.triggerAction, name: 'news', color: greenAccentColor, text:"SB News", icon:MyFlutter.newspaper),
            GridItem(color: greenAccentColor, text:"SB Academia", icon:Icons.school),
            GridItem(color: greenAccentColor, text:"SB Wiki", icon:MyFlutter.wikipedia_w),
            GridItem(color: greenAccentColor, text:"SB Videos", icon:MyFlutter.youtube_play),
            GridItem(color: greenAccentColor, text:"SB Networks", icon:MyFlutter.connectdevelop),
          ],
        ),

      ),
    );
  }
}