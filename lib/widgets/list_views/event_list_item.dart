import 'package:flutter/material.dart';
import 'package:social_business/entities/event.dart';
import 'package:social_business/screens/web_view_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart' as CNI;
import 'package:social_business/services/network_service.dart';
import 'package:toast/toast.dart';

class EventListItem extends StatelessWidget{

  Event event;


  EventListItem({Key key, this.event});

  @override
  Widget build(BuildContext context) {
    final String defaultImage = "images/thumbnail-default.jpg";
    //double c_width = MediaQuery.of(context).size.width*0.8;
    return Padding(
      key: UniqueKey(),
      padding: EdgeInsets.only(top: 5,bottom: 8,left: 5,right: 5),
      child: Card(

        elevation: 4,
        child: InkWell(
          onTap: () async{
            NetworkService.check().then((bool network){
              if(network){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WebViewDetailScreen(title:event.title,url:event.contentUrl)
                ));
              }else{
                Toast.show("Internet not available",context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER);
              }
            });

          },
          child:Padding(
            padding:EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black12),
                          left: BorderSide(width: 1.0, color: Colors.black12),
                          right: BorderSide(width: 1.0, color: Colors.black12)
                        )
                      ),
                      child:FadeInImage(
                        fit: BoxFit.fill,
                        placeholder: AssetImage(defaultImage),
                        image: (event.image != null)? CNI.CachedNetworkImageProvider(event.image) : AssetImage(defaultImage),
                      ),
                    )
                ]),
                Container(
                  color: Colors.black38,
                  constraints: BoxConstraints(
                      maxWidth: 342.0
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 7,bottom: 3,left: 7,right: 7),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(event.title, style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,),),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7,bottom: 3,left: 7,right: 7),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(event.venue, style: TextStyle(color: Colors.white,),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5,bottom: 7,left: 7,right: 7),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(event.startDate+" "+ event.startTime, style: TextStyle(color: Colors.white,),),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}