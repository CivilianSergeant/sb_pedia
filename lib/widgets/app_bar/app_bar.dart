import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppTitleBar{

  Color backgroundColor;
  String title;
  AppTitleBar({Key key,this.title="Social Business Pedia",this.backgroundColor});
  List<PopupMenuOption> options = <PopupMenuOption>[
    PopupMenuOption(title: "Refresh to update",name: 'rtu'),
    PopupMenuOption(title: "Help",name:'help'),
    PopupMenuOption(title: "Rate this app",name: 'rta'),
    PopupMenuOption(title: "Send Feedback",name: 'sf'),
    PopupMenuOption(title: "socialbusinesspedia.com",name: 'weblink'),
    PopupMenuOption(title: "yunuscentre.org",name: 'weblink')
  ];

  PreferredSizeWidget build() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton<PopupMenuOption>(
          itemBuilder: (BuildContext context){
            return options.map((PopupMenuOption option){
              return PopupMenuItem(
                value: option,
                child: Text(option.title),
              );
            }).toList();
          },
          onSelected: (PopupMenuOption option) async {
            switch(option.name){
              case 'rtu':
                break;
              case 'help':
                break;
              case 'rta':
                break;
              case 'sf':
                break;
              case 'weblink':
                await launch('http://'+option.title);
                break;
            }
          },
          elevation: 3,
        )
      ],
    );
  }
}

class PopupMenuOption{
  String title;
  String name;
  PopupMenuOption({this.title,this.name});
}