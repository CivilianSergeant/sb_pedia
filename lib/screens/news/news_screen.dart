import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/news_service.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/list_views/news_list_item.dart';
import 'package:sb_pedia/widgets/navigation_drawer/navigation_drawer.dart';

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
        appBar: appTitleBar.build(context),
        drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: Container(
            decoration: BoxDecoration(
              color: ColorList.home
            ),
            child:ListView.builder(

                itemCount: itemCount,
                itemBuilder: renderItems
            ) ,
          ),
          onRefresh: () async{
            if(!onLoadFlag){
              onLoadFlag=true;
            }else{
              String url = "http://sbes.socialbusinesspedia.com/api/sb_contents/content/news";
              final parsedJson = await NetworkService.fetch(url);
              List<News> newNews = NewsService().extractFromJson(parsedJson);
              if (newNews != null) {
                newNews.forEach((News n) => NewsService.addNews(n));
              }
            }

            return NewsService.getNews().then((dynamic lists){
              if(lists != null) {
                setState(() {
                  itemCount = lists.length;
                  allNews = lists;
                });
              }
            });
          },
        ),
      ),
    );
  }
}