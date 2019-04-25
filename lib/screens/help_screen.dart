import 'package:flutter/material.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';

class HelpScreen extends StatefulWidget{

  @override
  State createState() {
    return _HelpScreenState();
  }
}

class _HelpScreenState extends State<HelpScreen>{

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: "Help",backgroundColor: ColorList.greenColor);
    return Scaffold(
        appBar: appTitleBar.build(context),
        body: Container(),
    );
  }
}