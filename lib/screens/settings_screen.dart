import 'package:flutter/material.dart';
import 'package:social_business/entities/setting.dart';
import 'package:social_business/services/settings_service.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';

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
        appBar: appTitleBar.build(),
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
      print(setting.status);
      return Column(
        children: <Widget>[
          SwitchListTile(

            title: Text(setting.title),
            value: setting.status,
            onChanged: (value){
              setState(() {
                setting.status = value;
                SettingsService.updateSetting(setting);
              });
            },
          ),
          Divider()
        ],
      );
    }
  }
}