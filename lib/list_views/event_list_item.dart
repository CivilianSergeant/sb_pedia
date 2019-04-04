import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget{

  String title;
  String venue;
  String start;
  String end;

  EventListItem({Key key, this.title, this.start, this.end,this.venue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: (){

          },
          child:Padding(
            padding:EdgeInsets.only(top:5,bottom: 5 ,left: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 5),child:Text("Venue: "+venue),),
                          Padding(padding: EdgeInsets.only(top: 5),child:Text("Start: "+start),),
                          Padding(padding: EdgeInsets.only(top: 5),child:Text("Start: "+end),),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}