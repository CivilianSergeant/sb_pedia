import 'package:flutter/material.dart';
import 'package:social_business/screens/faq/faq_screen.dart';
import 'package:social_business/screens/help_screen.dart';
import 'package:social_business/screens/news/news_screen.dart';
import 'package:social_business/screens/notification/notification_screen.dart';
import 'package:social_business/screens/settings_screen.dart';
import 'package:social_business/screens/splash_screen.dart';
import 'package:social_business/screens/event/event_screen.dart';
import 'package:social_business/screens/home_screen.dart';
import 'package:social_business/screens/login_screen.dart';
import 'package:social_business/widgets/colors/color_list.dart';

void main() => runApp(MyApp());

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



