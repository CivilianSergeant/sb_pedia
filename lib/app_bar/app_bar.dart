import 'package:flutter/material.dart';

class AppTitleBar{

  Color backgroundColor;
  String title;
  AppTitleBar({Key key,this.title="Social Business Pedia",this.backgroundColor});
  final List<Option> options  = <Option>[
    Option(title: "Refresh to update"),
    Option(title: "Help"),
    Option(title: "Rate this App"),
    Option(title: "Send Feedback"),
    Option(title: "SocialBusinessPedia.com"),
    Option(title: "yunuscentre.org")
  ];



  PreferredSizeWidget build({dynamic state}) {
    if(state != null){
      print(state);
    }
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (BuildContext context){
            return options.map((Option option){
              return PopupMenuItem<Option>(
                value: option,
                child: Text(option.title),
              );
            }).toList();
          },
          elevation: 4,
        )
      ],
    );
  }
}

class Option {
  String title;

  Option({this.title});
}