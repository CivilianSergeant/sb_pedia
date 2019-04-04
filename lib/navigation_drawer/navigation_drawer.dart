import 'package:flutter/material.dart';
import 'package:flutter_demo/navigation_drawer/list_item.dart';
import 'package:flutter_demo/icons/my_flutter_icons.dart';
import 'package:flutter_demo/navigation_drawer/nav_drawer_header.dart';

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

            Navigator.popAndPushNamed(context,'/events');
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
                  child: NavDrawerHeader(color: accentColor, imagePath: imagePath,)
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    ListItem( name: 'acount-info', icon: Icons.info,iconColor: accentColor,text: "Account Information",textColor: accentColor),
                    ListItem(icon: Icons.lock,iconColor: accentColor,text: "Forget Password",textColor: accentColor),
                    Divider(),
                    Padding(padding:EdgeInsets.only(left: 20,top:4),child:Text("All Modules",style: TextStyle(color: accentColor))),
                    ListItem(callback:this.triggerAction, name:'events', icon: MyFlutter.calendar,iconColor: accentColor,text: "SB Events",textColor: accentColor),
                    ListItem(icon: MyFlutter.chart_line,iconColor: accentColor,text: "SB Design Lab",textColor: accentColor),
                    ListItem(icon: Icons.public,iconColor: accentColor,text: "SB World",textColor: accentColor),
                    ListItem(icon: Icons.school,iconColor: accentColor,text: "SB Academia",textColor: accentColor),
                    ListItem(icon: MyFlutter.newspaper,iconColor: accentColor,text: "SB News/Media",textColor: accentColor),
                    ListItem(icon: MyFlutter.wikipedia_w,iconColor: accentColor,text: "SB Wiki",textColor: accentColor),
                    ListItem(icon: MyFlutter.youtube_play,iconColor: accentColor,text: "SB Videos",textColor: accentColor),
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