import 'package:flutter/material.dart';

class AppTitleBar{

  Color backgroundColor;
  String title;
  AppTitleBar({Key key,this.title="Social Business Pedia",this.backgroundColor});


  PreferredSizeWidget build() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      centerTitle: true,
    );
  }
}