import 'package:flutter/material.dart';

class FaqListItem extends StatelessWidget{

  String text;
  Function callback;

  FaqListItem({Key key, this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(2),
      child: InkWell(
        highlightColor: Colors.black12,
        onTap: (){
          if(callback != null){
            callback();
          }
        },
        child: Container(
          child:Padding(
              padding: EdgeInsets.fromLTRB(10,10,10,10),
              child:Text(text) ,
            ),
          ),
        ),
    );
  }
}