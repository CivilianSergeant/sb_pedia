import 'package:flutter/material.dart';
import 'package:social_business/screens/faq/tabs/tab_one.dart';
import 'package:social_business/screens/faq/tabs/tab_two.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';

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
      preferredSizeWidget: TabBar(
        tabs: <Widget>[
          Tab( text: "FAQ",),
          Tab( text: "Inquiry",)
        ],
      )
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
          body: TabBarView(
            children: <Widget>[
              TabOne(),
              TabTwo()
            ],
          ),
        ),
      ),
    );
  }
}