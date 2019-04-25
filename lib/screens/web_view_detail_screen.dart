import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sb_pedia/widgets/app_bar/app_bar.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetailScreen extends StatefulWidget{

  String title;
  String url;
  WebViewDetailScreen({this.title,this.url});

  @override
  State createState() {

    return _EventDetailScreenState(title: title,url: url);
  }
}

class _EventDetailScreenState extends State<WebViewDetailScreen>{
  Completer<WebViewController> _controller = Completer<WebViewController>();

  String title;
  String url;

  _EventDetailScreenState({this.title,this.url});

  @override
  Widget build(BuildContext context) {
   // print('here'+title.toString());
    var appBar = AppTitleBar(title: title, backgroundColor: ColorList.greenColor);
    return Scaffold(
      appBar: appBar.build(context),
      backgroundColor: Colors.white,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}