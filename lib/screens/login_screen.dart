import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/user.dart';
import 'package:sb_pedia/screens/web_view_detail_screen.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/services/network_service.dart' as prefix0;
import 'package:sb_pedia/services/notification_service.dart';
import 'package:sb_pedia/services/user_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/navigation_drawer/list_item.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget{

  @override
  State createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>{

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _loginUrl = "http://socialbusinesspedia.com/cake_users_and_rbac/security/app_login";
  int _loginBtnState = 0;
  int _guestBtnState = 0;

  Widget showLoginButton(){
    if(_loginBtnState == 0){
      return Text(
        "Login",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
      );
    }else if (_loginBtnState == 1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }else{
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget showGuestButton(){
    if(_guestBtnState == 0){
      return Text(
        "Continue as Guest",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
      );
    }else if (_guestBtnState == 1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorList.greenAccentColor),
      );
    }else{
      return Icon(Icons.check, color: ColorList.greenAccentColor);
    }
  }

  Future launchScreen(String s) async{

    Map<String, dynamic> message = json.decode(s);

    if(message['data']['type'] == 'other'){
      await launch(message['data']['content_url']);
    }else{
      if(message['data']['content_url'] == null){
        Navigator.pushReplacementNamed(context, '/'+message['data']['screen']);
      }else{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewDetailScreen(
                title:message['data']['content_title'],
                url:message['data']['content_url'])
        ));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:  Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorList.greenAccentColor,
          image: new DecorationImage(
            image: new AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          bottom: true,
          child: ListView(
            children: <Widget>[

              Padding(padding: EdgeInsets.only(top: 60),
                child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image(
                    image: AssetImage("images/ic_launcher_512_n.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20,left:40,right: 40),
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: "Username",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color:ColorList.greenAccentColor),
                    labelStyle: new TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.only(top: 15,bottom: 15,
                    left: 10,right: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(

                padding: EdgeInsets.only(top:20,left:40,right: 40),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,

                    hintStyle: TextStyle(color:ColorList.greenAccentColor),
                    labelStyle: new TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.only(top: 15,bottom: 15,
                        left: 10,right: 10),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20,left:40,right: 40),
                child: SizedBox(
                width: double.infinity,
                height: 50,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: (){
                      setState(() {
                        Map<String,dynamic> data = {
                          'username' : _username.text,
                          'password' : _password.text
                        };
                        if(_loginBtnState==0) {
                          setState(() {
                            _loginBtnState = 1;
                          });
                          NetworkService.check().then((bool network){
                            if(network){
                              NetworkService.post(_loginUrl, data).then((
                                  Map<String, dynamic> res) {
                                if (res['code'] == 200) {

                                  User user = User.fromMap(res['user']);
                                  user.ID = 1;
                                  UserService.addUser(user);
                                  Map<String,dynamic> message = {
                                    'notification':{
                                      'title': 'Welcome to Social Business Pedia',
                                      'body': "Welcome to Social Business Pedia. "
                                          "Thanks for registration. From now you "
                                          "will be get update of all SB Pedia events",
                                      'sound':"default",
                                    },
                                    'data':{
                                      'is_top':1,
                                      'isWelcome':true
                                    }
                                  };
                                  NotificationService.raiseLocalNotification(message, this.launchScreen);
                                  Timer(Duration(seconds: 1),(){
                                    setState(() {
                                      _loginBtnState = 2;
                                    });
                                    Navigator.pushReplacementNamed(context, "/home");
                                  });

                                } else {
                                  Toast.show(res['error'], context, gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                  setState(() {
                                    _loginBtnState = 0;
                                  });
                                }

                              });
                            }else{
                              Toast.show("Internet not available", context,
                              gravity: Toast.CENTER,duration: Toast.LENGTH_LONG);
                              setState(() {
                                _loginBtnState = 0;
                              });
                            }
                          });
                        }
                      });
                    },
                    textColor: Colors.white,
                    child: showLoginButton(),
                    elevation: 4,
                    color: ColorList.greenAccentColor,

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:30),
                child: Container(),
              ),
              Container(
                alignment: Alignment.center,
                child:Padding(
                  padding: EdgeInsets.only(top:20,left:30,right: 30,),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("No Account ?",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Signup",style: TextStyle(color: ColorList.greenAccentColor,fontSize:20)),
                      )
                    ],
                  ),
                ) ,
              ),

              Padding(
                padding: EdgeInsets.only(top:20,left:30,right: 40,bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    color: Colors.white,
                    textColor: ColorList.greenAccentColor,
                    elevation: 4,
                    child: showGuestButton(),
                    onPressed: (){
                      if(_guestBtnState == 0){
                        setState(() {
                          _guestBtnState = 1;
                        });
                      }
                      final now = new DateTime.now();

                      String seconds = (now.millisecondsSinceEpoch/1000)
                                      .toString()
                                      .substring(0,10);
                      UserService.addUser(User(id: 1,userType: User.GUEST,username: "guest_"+seconds)).then((_){
                        Map<String,dynamic> message = {
                          'notification':{
                            'title': 'Welcome to Social Business Pedia',
                            'body': "Welcome to Social Business Pedia. "
                                "Thanks for registration. From now you "
                                "will be get update of all SB Pedia events",
                            'sound':"default",

                          },
                          'data':{
                            'is_top':1,
                            'isWelcome':true
                          }
                        };
                        NotificationService.raiseLocalNotification(message, this.launchScreen);
                        Timer(Duration(seconds: 1),(){
                          setState(() {
                            _guestBtnState = 2;
                          });
                          Navigator.pushReplacementNamed(context, "/home");
                        });
                      });

                    },
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}