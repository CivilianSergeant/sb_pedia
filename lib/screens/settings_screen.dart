import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/setting.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/settings_service.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:toast/toast.dart';

class SettingsScreen extends StatefulWidget{
  @override
  State createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen>{

  dynamic settings;
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: "Settings", backgroundColor: ColorList.greenColor);
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
        appBar: appTitleBar.build(context),
        drawer: NavigationDrawer(color: ColorList.greenColor,accentColor: ColorList.greenAccentColor),
        body: Container(
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: renderItems
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SettingsService.getSettings().then((List<Setting> settings){
      setState(() {
        itemCount = settings.length;
        this.settings = settings;
      });
    });
  }



  Widget renderItems(BuildContext context, int i){
    if(settings != null) {
      Setting setting = settings[i];

      return Column(
        children: <Widget>[
          SwitchListTile(

            title: Text(setting.title),
            subtitle: Text(setting.description),
            value: setting.status,
            onChanged: (value){
              setState(() {
                setting.status = value;
                SettingsService.updateSetting(setting).then((int value)  {
                    SettingsService.getSettings().then((List<Setting> _settings) async {
                      List latestSetting = List<String>();

                      _settings.forEach((Setting _setting){
                        if(_setting.status)
                          latestSetting.add(_setting.alias);
                      });

                      String settingStr = "["+latestSetting.join(",")+"]";

                      print(settingStr);
                      String url = "http://sbes.socialbusinesspedia.com/api/sb_security/setting";
                      NetworkService.post(url, {
                        'imei': await SettingsService.getImei(),
                        'setting': settingStr
                      }).then((Map<String,dynamic> res){

                        if(res['status']==200){
                          Toast.show("Setting successfully updated", context,
                              gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                        }
                      });
                    });
                });
              });
            },
          ),
          Divider()
        ],
      );
    }
  }
}