import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/notification.dart' as SBNotification;
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:toast/toast.dart';

class NotificationListItem extends StatelessWidget{
  SBNotification.Notification notification;

  NotificationListItem({this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 8,right: 8,bottom: 5, top: 5),
      color: (notification.url != null)? ColorList.deepBlueGreen : Colors.white,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(7, 10, 7, 3),
                child: Text(notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: (notification.url != null)? Colors.white :
                          Colors.black
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(7, 5, 7, 10),
                child:Text(notification.message,
                style: TextStyle(
                    color: (notification.url != null)? Colors.white :
                    Colors.black87
                ),)
            ),
          ],
        ),
      ),
    );
  }
}