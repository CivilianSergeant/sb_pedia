import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/event.dart';
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart' as CNI;
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
class EventListItem extends StatelessWidget{

  Event event;


  EventListItem({Key key, this.event});

  @override
  Widget build(BuildContext context) {
    final String defaultImage = "images/thumbnail-default.jpg";
    //double c_width = MediaQuery.of(context).size.width*0.8;
    var formatter = DateFormat.yMMMMd("en_US");
    var eventStartDate = event.startDate.split('-');
    var dateTime = DateTime(int.parse(eventStartDate[0]),int.parse(eventStartDate[1]),int.parse(eventStartDate[2]));

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
                ClipRRect(
                  borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)
                  ) ,
                  child: FadeInImage(
                    width: double.infinity,
                    placeholder: AssetImage(defaultImage),
                    image: (event.image != null)? CNI.CachedNetworkImageProvider(event.image) : AssetImage(defaultImage),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: 342.0
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 7,bottom: 3,left: 7,right: 7),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(event.title,
                              style: TextStyle(
                                fontWeight:FontWeight.bold,
                                color: ColorList.greenAccentColor,),),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7,bottom: 3,left: 7,right: 7),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(event.venue,
                            style: TextStyle(color: ColorList.greenAccentColor,),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5,bottom: 7,left: 7,right: 7),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(formatter.format(dateTime),
                            style: TextStyle(color: ColorList.greenAccentColor,),),
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