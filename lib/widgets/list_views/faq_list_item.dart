import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/faq.dart';

class FaqListItem extends StatelessWidget{

  Faq faq;
  Function callback;

  FaqListItem({Key key, this.faq, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(2),
      child: InkWell(
        highlightColor: Colors.black12,
        onTap: (){
          if(callback != null){
            callback(faq);
          }
        },
        child: Container(
          child:Padding(
              padding: EdgeInsets.fromLTRB(10,10,10,10),
              child:Text(faq.question) ,
            ),
          ),
        ),
    );
  }
}