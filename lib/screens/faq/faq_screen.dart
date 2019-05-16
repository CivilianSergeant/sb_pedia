import 'package:flutter/material.dart';
import 'package:sb_pedia/screens/faq/tabs/tab_one.dart';
import 'package:sb_pedia/screens/faq/tabs/tab_two.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/navigation_drawer/navigation_drawer.dart';

class FaqScreen extends StatefulWidget{

  @override
  State createState() {
    return _FaqScreenState();
  }
}

class _FaqScreenState extends State<FaqScreen>{




  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title:"Social Business Q & A",backgroundColor: ColorList.greenColor,
//      preferredSizeWidget: TabBar(
//        tabs: <Widget>[
//          Tab( text: "FAQ",),
//          Tab( text: "Inquiry",)
//        ],
//      ),
    );
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
          appBar: appTitleBar.build(context),
          body: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: ColorList.greenAccentColor,
                  child:TabBar(
                    indicatorColor: ColorList.deepBlueGreen,
                    tabs: <Widget>[
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
//                        color: Colors.red,
                        child: Tab( text: "FAQ",),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
//                        color:Colors.blue,
                        child: Tab( text: "Inquiry",),
                      )

                    ],
                  ) ,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    TabOne(),
                    TabTwo()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}