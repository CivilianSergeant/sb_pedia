import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetailScreen extends StatefulWidget{

  String title;
  String url;
  WebViewDetailScreen({this.title,this.url});

  @override
  State createState() {
    return _EventDetailScreenState();
  }
}

class _EventDetailScreenState extends State<WebViewDetailScreen>{
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    var appBar = AppTitleBar(title: widget.title, backgroundColor: ColorList.greenColor);
    return Scaffold(
      appBar: appBar.build(context),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}