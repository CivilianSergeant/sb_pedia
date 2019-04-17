import 'package:flutter/material.dart';
import 'package:social_business/entities/news.dart';
import 'package:social_business/services/news_service.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/widgets/list_views/news_list_item.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';

class NewsScreen extends StatefulWidget{

  @override
  State createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen>{

  dynamic allNews;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  int itemCount = 0;
  bool onLoadFlag = false;

  @override
  void initState() {
    super.initState();
    onLoadFlag = false;
    _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  Widget renderItems(BuildContext context, int i) {
    if(allNews != null) {
      News news = allNews[i];
      return NewsListItem(key:UniqueKey(),news: news,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: 'All News List', backgroundColor: ColorList.greenColor);

    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
        appBar: appTitleBar.build(),
        drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12
            ),
            child:ListView.builder(

                itemCount: itemCount,
                itemBuilder: renderItems
            ) ,
          ),
          onRefresh: () async{
            if(!onLoadFlag){
              onLoadFlag=true;
              return NewsService.getNews().then((dynamic lists){
                if(lists != null) {
                  setState(() {
                    itemCount = lists.length;
                    allNews = lists;
                  });
                }
              });
            }else{

            }
          },
        ),
      ),
    );
  }
}