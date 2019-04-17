import 'package:flutter/material.dart';
import 'package:social_business/entities/user.dart';
import 'package:social_business/services/user_service.dart';
import 'package:social_business/widgets/colors/color_list.dart';

class LoginScreen extends StatefulWidget{

  @override
  State createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorList.greenAccentColor,
            image: new DecorationImage(
              image: new AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
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
              padding: EdgeInsets.only(top:20,left:30,right: 30),
              child: TextField(

                decoration: InputDecoration(
                  hintText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color:ColorList.greenAccentColor),
                  labelStyle: new TextStyle(color: Colors.white),

                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:20,left:30,right: 30),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color:ColorList.greenAccentColor),
                  labelStyle: new TextStyle(color: Colors.white),

                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:20,left:30,right: 30),
              child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                color: ColorList.greenAccentColor,
                textColor: Colors.white,
                elevation: 4,
                child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                onPressed: (){

                },
              )
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top:20,left:30,right: 30,bottom: 10),
              child: Text("No Account ?",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(top:20,left:30,right: 30,bottom: 30),
              child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    elevation: 4,
                    child: const Text("Guest",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    onPressed: (){
                      UserService.addUser(User(id: 1,userType: User.GUEST,username: "Guest User"));
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}