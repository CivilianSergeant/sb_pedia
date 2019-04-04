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

    return RandomWords();
  }
}

class RandomWords extends StatefulWidget{

  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  Color greenColor = ColorList.greenColor;
  Color greenAccentColor = ColorList.greenAccentColor;

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
  Widget build(BuildContext context) {
    var appTitleBar = AppTitleBar(backgroundColor: ColorList.greenColor);

    return Scaffold(
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