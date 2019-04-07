import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
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

class HomePageWidgetState extends State<HomePageWidget> with WidgetsBindingObserver  {

  Color greenColor = ColorList.greenColor;
  Color greenAccentColor = ColorList.greenAccentColor;
  AppLifecycleState state;
  static int backButtonState = 0;
  void triggerAction (BuildContext context,String actionName){

    switch(actionName){
      case "events":

        Navigator.of(context).pushNamed('/events');
        break;
      default:
        break;
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    print(state);
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      this.state = state;
    });
    print(state);
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

    return  Scaffold(
        key: Key("home"),
        appBar: appTitleBar.build(),
        drawer: NavigationDrawer(color: greenColor,accentColor: greenAccentColor,imagePath: IMAGE_URL,),
        body: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(8),
          children: <Widget>[
            GridItem(callback:this.triggerAction, name: 'events',color: greenAccentColor, text:"SB Event", icon: MyFlutter.calendar,),
            GridItem(color: greenAccentColor, text:"SBAC", icon: MyFlutter.chart_line,),
            GridItem(color: greenAccentColor, text:"SB World", icon: Icons.public,),
            GridItem(color: greenAccentColor, text:"SB Design Lab", icon:MyFlutter.chart_pie),
            GridItem(color: greenAccentColor, text:"SB News", icon:MyFlutter.newspaper),
            GridItem(color: greenAccentColor, text:"SB Academia", icon:Icons.school),
            GridItem(color: greenAccentColor, text:"SB Wiki", icon:MyFlutter.wikipedia_w),
            GridItem(color: greenAccentColor, text:"SB Videos", icon:MyFlutter.youtube_play),
            GridItem(color: greenAccentColor, text:"SB Networks", icon:MyFlutter.connectdevelop),
          ],
        ),

    );
  }
}