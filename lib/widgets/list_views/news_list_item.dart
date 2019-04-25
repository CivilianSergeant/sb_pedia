import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/news.dart';
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart' as CNI;
import 'package:sb_pedia/services/network_service.dart';
import 'package:toast/toast.dart';
class NewsListItem extends StatelessWidget{

  News news;

  NewsListItem({Key key, this.news});

  @override
  Widget build(BuildContext context) {
    final title = (news != null)? ((news.title.length> 115)? news.title.substring(0,115)+'...' : news.title) : 'Loading...';
    final description = (news != null) ? ((news.description.length> 70)? news.description.substring(0,70)+'...' : news.description) : 'Loading...';
    return Card(
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
              margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
              decoration: BoxDecoration(
                  color:Colors.black
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
                  maxWidth: 244,
                  maxHeight: 96
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(title,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
                      child:Text(description,
                        style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold,fontSize: 12),
                      )
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child:Text("Publish date: "+news.publishDate,
                        style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold,fontSize: 12),
                      )
                  ),
                ],
              ),
            )
          ],
        ) ,
      ),
    );
  }
}