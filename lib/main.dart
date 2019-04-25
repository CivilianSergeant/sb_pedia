import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sb_pedia/screens/faq/faq_screen.dart';
import 'package:sb_pedia/screens/help_screen.dart';
import 'package:sb_pedia/screens/news/news_screen.dart';
import 'package:sb_pedia/screens/notification/notification_screen.dart';
import 'package:sb_pedia/screens/settings_screen.dart';
import 'package:sb_pedia/screens/splash_screen.dart';
import 'package:sb_pedia/screens/event/event_screen.dart';
import 'package:sb_pedia/screens/home_screen.dart';
import 'package:sb_pedia/screens/login_screen.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';

void main() =>  SystemChrome
    .setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {runApp(MyApp());
    });

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SB Pedia',
      theme: ThemeData(
        primaryColor: ColorList.greenColor,
        accentColor: ColorList.greenColor,

      ),
      home: SplashScreen(),
      routes:{
        '/login' : (context) => LoginScreen(),
        '/home'  : (context) => HomeScreen(),
        '/events': (context) => EventScreen(),
        '/news'  : (context) => NewsScreen(),
        '/notifications' : (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(),
        '/faqs' : (context) => FaqScreen(),
        '/help' : (context) => HelpScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}



