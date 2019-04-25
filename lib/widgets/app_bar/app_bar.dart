import 'package:flutter/material.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/settings_service.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AppTitleBar{

  Color backgroundColor;
  String title="Social Business Pedia";
  PreferredSizeWidget preferredSizeWidget;
  AppTitleBar({Key key,this.title="Social Business Pedia",this.backgroundColor, this.preferredSizeWidget});
  List<PopupMenuOption> options = <PopupMenuOption>[
    PopupMenuOption(title: "Refresh to update",name: 'rtu'),
    PopupMenuOption(title: "Help",name:'help'),
    PopupMenuOption(title: "Rate this app",name: 'rta'),
    PopupMenuOption(title: "Send Feedback",name: 'sf'),
    PopupMenuOption(title: "socialbusinesspedia.com",name: 'weblink'),
    PopupMenuOption(title: "yunuscentre.org",name: 'weblink')
  ];

  PreferredSizeWidget build(BuildContext context) {

    return AppBar(
      backgroundColor: backgroundColor,
      title: (this.title != null )? Text(this.title) : Text(' '),
      centerTitle: true,
      bottom: preferredSizeWidget,
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
          onSelected: (PopupMenuOption option) {
            switch(option.name){
              case 'rtu':
                Toast.show("Refreshing ... ",context,duration: Toast.LENGTH_SHORT,gravity:Toast.CENTER);
                String url = "http://sbes.socialbusinesspedia.com/api/sb_contents/content";
                NetworkService.fetch(url).then((Map<String,dynamic> parsedJson){
                  if(parsedJson==null){
                    Toast.show("Internet not available",context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER);
                  }
                  SettingsService.refreshAndLoadData(parsedJson);
                });

                break;
              case 'help':
                Navigator.of(context).pushNamed('/help');
                break;
              case 'rta':
                break;
              case 'sf':
                break;
              case 'weblink':
                NetworkService.check().then((bool network) async {
                  if(network){
                    await launch('http://'+option.title);
                  }else{
                    Toast.show("Internet not available",context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER);
                  }
                });

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