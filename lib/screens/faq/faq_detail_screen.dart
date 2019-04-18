import 'package:flutter/material.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';

class FaqDetailScreen extends StatefulWidget{

  String title;

  FaqDetailScreen({this.title});

  @override
  State createState() {
    return _FaqDetailScreenState();
  }
}

class _FaqDetailScreenState extends State<FaqDetailScreen>{

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: widget.title, backgroundColor: ColorList.greenColor);
    return Scaffold(
      appBar: appTitleBar.build(context),
      body: Container(),
    );
  }
}