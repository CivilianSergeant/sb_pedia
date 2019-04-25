import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/notification.dart' as SBNotification;
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/notification_service.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/list_views/notification_list_item.dart';
import 'package:sb_pedia/widgets/navigation_drawer/navigation_drawer.dart';

class NotificationScreen extends StatefulWidget{

  @override
  State createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen>{
  dynamic notifications;
  int itemCount = 0;
  bool onLoadFlag = false;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorState;


  @override
  void initState() {
    super.initState();
    onLoadFlag = false;
    _refreshIndicatorState = GlobalKey<RefreshIndicatorState>();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorState.currentState?.show();
    });
  }

  Widget renderItems (BuildContext context , int i){
    if(notifications != null){
      SBNotification.Notification notification = notifications[i];
      return NotificationListItem(notification: notification);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: 'All Notifications', backgroundColor: ColorList.greenColor);

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
        appBar: appTitleBar.build(context),
        drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
        body: RefreshIndicator(
          key: _refreshIndicatorState,
          child: Container(
            color:Colors.black12,
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: renderItems
            ),
          ),
          onRefresh: () async {
            if(onLoadFlag == false){
              onLoadFlag = true;
            }else{
              String url = "http://sbes.socialbusinesspedia.com/api/sb_contents/content/notification";
              final parsedJson = await NetworkService.fetch(url);
              List<SBNotification.Notification> newNotifications = NotificationService().extractFromJson(parsedJson);
              if(newNotifications != null){
                newNotifications.forEach((SBNotification.Notification n){
                  NotificationService.addNotification(n);
                });
              }
            }
            return NotificationService.getNotifications().then((dynamic lists) {
              if(lists != null){
                setState(() {
                  itemCount = lists.length;
                  notifications = lists;
                });
              }
            });
          },
        )
      ),
    );
  }
}