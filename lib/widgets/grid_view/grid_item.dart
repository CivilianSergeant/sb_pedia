import 'package:flutter/material.dart';

class GridItem extends StatelessWidget{

  Color color;
  String text;
  IconData icon;
  Function callback;
  String name;
  GridItem({Key key, this.name, this.callback, this.color,this.text,this.icon});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child:  Card(
        margin: EdgeInsets.all(10),
        elevation:0,

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 7 )]
            ),
          child: InkWell(
            highlightColor: Colors.white,
            onTap: (){
              if(callback != null){
                callback(context,name);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top:10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon,size: 70,color: color,),
                  Padding(padding: EdgeInsets.only(top:10),
                      child:Text(text,
                        style: TextStyle(color: Colors.black87,
                            fontWeight: FontWeight.normal),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}