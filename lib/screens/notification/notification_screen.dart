import 'package:flutter/material.dart';
import 'package:social_business/entities/notification.dart' as SBNotification;
import 'package:social_business/services/notification_service.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/widgets/list_views/notification_list_item.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';

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
        appBar: appTitleBar.build(),
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
          onRefresh: () {
            if(onLoadFlag == false){
              onLoadFlag = true;
              return NotificationService.getNotifications().then((dynamic lists) {
                if(lists != null){
                  setState(() {
                    itemCount = lists.length;
                    notifications = lists;
                  });
                }
              });
            }else{
              return Future<Null>.value(null);
            }
          },
        )
      ),
    );
  }
}