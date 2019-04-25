import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/faq.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
class FaqDetailScreen extends StatefulWidget{

  String title;
  Faq faq;


  FaqDetailScreen({this.title,this.faq});

  @override
  State createState() {
    return _FaqDetailScreenState();
  }
}

class _FaqDetailScreenState extends State<FaqDetailScreen>{

  @override
  Widget build(BuildContext context) {
    final appTitleBar = AppTitleBar(title: widget.faq.question, backgroundColor: ColorList.greenColor);
    return Scaffold(
      appBar: appTitleBar.build(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(widget.faq.question,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child:HtmlTextView(
                data: widget.faq.answer
              ),
            )
          ],
        ),
      ),
    );
  }
}