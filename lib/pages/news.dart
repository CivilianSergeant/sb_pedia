import 'package:flutter/material.dart';
import 'package:flutter_demo/app_bar/app_bar.dart';
import 'package:flutter_demo/colors/color_list.dart';
import 'package:flutter_demo/navigation_drawer/navigation_drawer.dart';

class News extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var appTitleBar = AppTitleBar(title: "SB News", backgroundColor: ColorList.greenColor);
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
          appBar: appTitleBar.build(),
          drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
          body:null
      ),
    );
  }
}