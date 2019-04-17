import 'package:flutter/material.dart';

class ListItem extends StatelessWidget{
  IconData icon;
  Color iconColor;
  String text;
  Color textColor;
  Function callback;
  String name;
  ListItem({this.name,this.icon,this.iconColor,this.text,this.textColor,this.callback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if(callback!=null)
        {
          callback(context,name);
        }
      },
      leading: Container(
          padding: EdgeInsets.all(0),
          child:Row(
            children: <Widget>[
              Icon(icon,color: iconColor,),
              Padding(padding:EdgeInsets.only(left:10),child:Text(text,style: TextStyle(color: textColor),))
            ],
          )
      ),
    );
  }
}