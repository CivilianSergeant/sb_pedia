import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_business/entities/news.dart';
import 'package:social_business/entities/notification.dart' as SBNotification;
import 'package:social_business/services/news_service.dart';
import 'package:social_business/services/notification_service.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/widgets/grid_view/grid_item.dart';
import 'package:social_business/widgets/list_views/news_list_item.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:social_business/widgets/icons/my_flutter_icons.dart';

class HomeScreen extends StatelessWidget{

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

  SBNotification.Notification notification;
  News news;
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
      case "notifications":
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
      case "faqs":
        Navigator.pushReplacementNamed(context, '/faqs');
        break;
      default:
        break;
    }
  }

  void loadData(){
    NotificationService.getLatestNotification().then((SBNotification.Notification n){
      setState(() {
        notification = n;
      });
    });

    NewsService.getLatestNews().then((News news){
      setState(() {
        this.news = news;
      });
    });

  }

  Widget renderLatestNotification(){
    if(notification == null){
      return Container();
    }
    return Card(
        margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              color: ColorList.greenAccentColor
          ),
          child:Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
            child: Text(notification.title,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ) ,
        )
    );
  }

  Widget renderLatestNews(){
    if(news == null){
      return Container();
    }

    return NewsListItem(news: news,);
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
            //print('android');
            androidMessageChannel.invokeMethod("sendAppToBackground");
          }else{
            //print('ios');
            _exitApp(context);
          }
        }
      },
      child: Scaffold(
        key: Key("home"),
        appBar: appTitleBar.build(context),
        drawer: NavigationDrawer(color: ColorList.greenColor,accentColor: ColorList.greenAccentColor,imagePath: IMAGE_URL,),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black12
          ),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              renderLatestNotification(),
              renderLatestNews(),
              GridView.count(
                shrinkWrap: true,
                primary: true,
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(2),
                  children: <Widget>[

                    GridItem(callback:this.triggerAction, name: 'news', color: ColorList.greenAccentColor, text:"SB News", icon:MyFlutter.newspaper),
                    GridItem(callback:this.triggerAction, color: ColorList.greenAccentColor, name: 'notifications', text:"Notifications", icon: Icons.notifications,),
                    GridItem(callback:this.triggerAction, color: ColorList.greenAccentColor, name: 'faqs', text:"SB Q&A", icon: Icons.help_outline,),
                    GridItem(callback:this.triggerAction, name: 'events',color: ColorList.greenAccentColor, text:"SB Event", icon: MyFlutter.calendar,),
//            GridItem(color: ColorList.greenAccentColor, text:"SB Design Lab", icon:MyFlutter.chart_pie),
//
//            GridItem(color: ColorList.greenAccentColor, text:"SB Academia", icon:Icons.school),
//            GridItem(color: ColorList.greenAccentColor, text:"SB Wiki", icon:MyFlutter.wikipedia_w),
//            GridItem(color: ColorList.greenAccentColor, text:"SB Videos", icon:MyFlutter.youtube_play),
//            GridItem(color: ColorList.greenAccentColor, text:"SB Networks", icon:MyFlutter.connectdevelop),
                  ],
                ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Content Provider: socialbusinesspedia.com",
                    style: TextStyle(fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}