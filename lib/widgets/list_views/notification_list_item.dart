import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/notification.dart' as SBNotification;

class NotificationListItem extends StatelessWidget{
  SBNotification.Notification notification;

  NotificationListItem({this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
            child: Text(notification.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
            child:Text(notification.message)
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
              child:Text("Sent date: " + notification.sentDate)
          )
        ],
      ),
    );
  }
}