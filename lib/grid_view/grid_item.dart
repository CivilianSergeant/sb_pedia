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
        elevation:2,
        child: InkWell(
          onTap: (){
            if(callback != null){
              callback(context,name);
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top:10),
              child:Column(
                children: <Widget>[
                  Icon(icon,size: 60,color: color,),
                  Padding(padding: EdgeInsets.only(top:10),child:Text(text,style: TextStyle(color: color,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}