import 'package:flutter/material.dart';
import 'package:sb_pedia/widgets/navigation_drawer/list_item.dart';
import 'package:sb_pedia/widgets/icons/my_flutter_icons.dart';
import 'package:sb_pedia/widgets/navigation_drawer/nav_drawer_header.dart';

const String IMAGE_URL = "images/avatar.png";

class NavigationDrawer extends StatelessWidget{



  Color color;
  Color accentColor;
  String imagePath;
  NavigationDrawer({this.color,this.accentColor,this.imagePath=IMAGE_URL});

  void triggerAction(BuildContext context, String actionName){
    Navigator.popUntil(context, (route){
      switch(actionName){
        case "events":
          if(route.settings.name != "/events"){
            Navigator.pushReplacementNamed(context,'/events');
          }else{
            Navigator.pop(context);
          }
          break;
        case "news":
          if(route.settings.name != "/news"){
            Navigator.pushReplacementNamed(context, '/news');
          }else{
            Navigator.pop(context);
          }
          break;
        case "notifications":
          if(route.settings.name != "/notifications"){
            Navigator.pushReplacementNamed(context, '/notifications');
          }else{
            Navigator.pop(context);
          }
          break;
        case "faqs":
          if(route.settings.name != "/faqs"){
            Navigator.pushReplacementNamed(context, '/faqs');
          }else{
            Navigator.pop(context);
          }
          break;
        case "settings":
          if(route.settings.name != "/settings"){
            Navigator.pushReplacementNamed(context, '/settings');
          }else{
            Navigator.pop(context);
          }
          break;

      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Container(
        color:accentColor,
        child: new Column(
          children: <Widget>[
            SizedBox(
                  height:225,
                  child: NavDrawerHeader(color: accentColor,
                    imagePath: imagePath,)
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
//                    ListItem( name: 'acount-info',
//                        icon: Icons.info,
//                        iconColor: accentColor,
//                        text: "Account Information",
//                        textColor: accentColor),
//                    ListItem(icon: Icons.lock,
//                        iconColor: accentColor,
//                        text: "Forget Password",
//                        textColor: accentColor),

//                    Padding(padding:EdgeInsets.only(left: 20,top:4),
//                      child:Text("All Modules",
//                      style: TextStyle(color: accentColor)
//                      )
//                    ),

//                    ListItem(icon: MyFlutter.chart_line,
//                        iconColor: accentColor,text: "SB Design Lab",
//                        textColor: accentColor),
//                    ListItem(icon: Icons.public,
//                        iconColor: accentColor,
//                        text: "SB World",
//                        textColor: accentColor),
//                    ListItem(icon: Icons.school,
//                        iconColor: accentColor,
//                        text: "SB Academia",
//                        textColor: accentColor),

                    ListItem(
                        name:'news',
                        callback:this.triggerAction,
                        icon: MyFlutter.newspaper,
                        iconColor: accentColor,
                        text: "SB News/Media",
                        textColor: accentColor),
                    ListItem(
                        name: 'notifications',
                        callback:this.triggerAction,
                        icon: Icons.notifications,
                        iconColor: accentColor,
                        text: "Notifications",
                        textColor: accentColor),
                    ListItem(
                        name: 'faqs',
                        callback: this.triggerAction,
                        icon: Icons.help_outline,
                        iconColor: accentColor,
                        text: "SB Q & A",
                        textColor: accentColor),
                    ListItem(
                        name:'events',
                        callback:this.triggerAction,
                        icon: MyFlutter.calendar,
                        iconColor: accentColor,text: "SB Events",
                        textColor: accentColor),
                    Divider(),
                    ListItem(
                        name: 'settings',
                        callback: this.triggerAction,
                        icon: Icons.settings,
                        iconColor: accentColor,
                        text: "Notification Settings",
                        textColor: accentColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}