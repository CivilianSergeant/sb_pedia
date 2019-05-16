import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/entities/notification.dart' as SBNotification;
import 'package:sb_pedia/entities/user.dart';
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/news_service.dart';
import 'package:sb_pedia/services/notification_service.dart';
import 'package:sb_pedia/services/user_service.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/grid_view/grid_item.dart';
import 'package:sb_pedia/widgets/list_views/news_list_item.dart';
import 'package:sb_pedia/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:sb_pedia/widgets/icons/my_flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info/device_info.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int _resumeStateNotification = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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

  Future<String> getImei() async{
    var imei = await ImeiPlugin.getImei;
    return imei;
  }

  Widget renderLatestNotification(){
    if(notification == null){
      return Container();
    }
    return Card(
      margin: EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
      child: InkWell(
        onTap: (){

          if(notification.url != null) {
            NetworkService.check().then((bool network) {
              if (network) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WebViewDetailScreen(
                      title: notification.title,
                      url: notification.url,)
                ));
              } else {
                Toast.show("Internet not available", context,
                    gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
              }
            });
          }
        },
        child: Container(
          
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: ColorList.deepBlueGreen
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 2),
                child: Text(notification.title ?? "Loading",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 15),
                child: Text(notification.message ?? "Loading",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderLatestNews(){
    if(news == null){
      return Container();
    }

    return NewsListItem(news: news,);
  }

  void firebaseMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) async {
      final IMEI = await getImei();
      final registerDeviceData = {
          'imei' : IMEI,
          'fcm_token' : token,
        };
//      print(token);
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        registerDeviceData['platform'] = 'android';
        registerDeviceData['device_id'] = androidInfo.id;
        registerDeviceData['model'] = androidInfo.model;
      }

      if(Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        registerDeviceData['platform'] = 'iphone';
        registerDeviceData['device_id'] = iosInfo.identifierForVendor;
        registerDeviceData['model'] = iosInfo.utsname.machine;
      }

      if(token.isNotEmpty){
        //print(jsonEncode(registerDeviceData));
        String url = "http://sbes.socialbusinesspedia.com/api/sb_security/fcm";
        NetworkService.post(url, registerDeviceData).then((Map<String,dynamic> res){
          if(res['status']==200){
            // handle
          }
        });
      }

    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        NotificationService.raiseLocalNotification(message, this.launchScreen).then((_){
          loadData();
        });

      },
      onResume: (Map<String, dynamic> message) async {
        if(_resumeStateNotification>0){
          return;
        }
        Future.delayed(Duration(milliseconds: 200),(){
          NotificationService.addNotification(SBNotification.Notification.fromMap({
            'is_top': message['data']['is_top'],
            'title' : message['data']['title'],
            'message' : message['data']['body'],
            'url' : message['data']['content_url']
          }),welcome: false);
          this.launchScreen(json.encode(message));
          setState(() {
            loadData();
            backButtonState = 1;
            _resumeStateNotification  = 1;
          });
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        if(backButtonState>0){
          return;
        }
        Future.delayed(Duration(milliseconds: 200),(){
          NotificationService.addNotification(SBNotification.Notification.fromMap({
            'is_top': message['data']['is_top'],
            'title' : message['data']['title'],
            'message' : message['data']['body'],
            'url' : message['data']['content_url']
          }),welcome: false);
          this.launchScreen(json.encode(message));
          setState(() {
            loadData();
            backButtonState = 1;
            _resumeStateNotification = 0;
          });
        });

      },
    );
  }

  Future launchScreen(String s) async{

    Map<String, dynamic> message = json.decode(s);


    if(message['data']['type'] == 'news' || message['data']['type'] == 'events'
    || message['data']['type'] == 'notifications'){
      if(message['data']['content_url'] == null){
        Navigator.pushReplacementNamed(context, '/'+message['data']['screen']);
      }else{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewDetailScreen(
                title:message['data']['content_title'],
                url:message['data']['content_url'])
        ));
      }
    }else{ // for others
      await launch(message['data']['content_url']);
    }
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();

    firebaseMessagingListeners();

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
        drawer: NavigationDrawer(color: ColorList.greenColor,accentColor: ColorList.greenAccentColor),
        body: Container(
          decoration: BoxDecoration(
            color: ColorList.home
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

                  children: <Widget>[

                    GridItem(callback:this.triggerAction,
                        name: 'news', color: ColorList.greenAccentColor,
                        text:"SB News", icon:MyFlutter.newspaper),
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
                    style: TextStyle(fontWeight: FontWeight.normal
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