import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart' as CNI;
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class NewsListItem extends StatelessWidget{

  News news;

  NewsListItem({Key key, this.news});

  @override
  Widget build(BuildContext context) {
    final title = (news != null)? ((news.title.length> 115)? news.title.substring(0,115)+'...' : news.title) : 'Loading...';
    final description = (news != null) ? ((news.description.length> 70)? news.description.substring(0,70)+'...' : news.description) : 'Loading...';

    var formatter = DateFormat.yMMMMd("en_US");
    var eventStartDate = news.publishDate.split('-');
    var dateTime = DateTime(int.parse(eventStartDate[0]),int.parse(eventStartDate[1]),int.parse(eventStartDate[2]));

    return Container(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.only(left: 8,right: 8,top:10,bottom: 10),
          child: InkWell(
            onTap: (){
              NetworkService.check().then((bool network){
                if(network){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => WebViewDetailScreen(title:news.title,url:news.contentUrl)
                  ));
                }else{
                  Toast.show("Internet not available",context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER);
                }
              });
            },
            child:Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,

                  decoration: BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                  ),
                  child: FadeInImage(
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                    placeholder: AssetImage('images/thumbnail-default.jpg'),
                    image: ((news.image != null)? CNI.CachedNetworkImageProvider(news.image) : AssetImage('images/thumbnail-default.jpg')),
                  ),
                )
                ,
                Container(
                  alignment: Alignment.topLeft,
                  constraints: BoxConstraints(
                      maxWidth: 236,
                      maxHeight: 96
                  ),
                  padding: EdgeInsets.only(top: 5,left: 8,bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(title,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,
                              color: ColorList.greenAccentColor),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
                          child:Text(description,
                            style: TextStyle(color:Colors.black87,fontWeight: FontWeight.bold,fontSize: 11),
                          )
                      ),
                      Spacer(),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:Text("Publish Date: "+formatter.format(dateTime),
                            style: TextStyle(color:Colors.black45,fontWeight: FontWeight.bold,fontSize: 10),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ) ,
          ),
        ),
      );
  }
}