import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/user.dart';
import 'package:sb_pedia/services/user_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';

class NavDrawerHeader extends StatelessWidget{


  Color color;

  NavDrawerHeader({Key key, this.color});



  @override
  Widget build(BuildContext context) {

    return DrawerHeader(

      child: UserInfo(),
      decoration: BoxDecoration(
        color: color,
        border: new Border.all(color: Colors.transparent)
      ),
    );
  }
}

class UserInfo extends StatefulWidget{




  @override
  State createState() {
    return _UserInfoState();
  }
}

class _UserInfoState extends State<UserInfo>{

  String _username = "Username";
  String _imagePath;
  String _userType;

  Widget getLoginButton(){
    if(_userType == User.GUEST){
      return InkWell(
        onTap: (){
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Column(
              children: <Widget>[
                Text("Login", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
//                Text("UI/Ux Designer",style: TextStyle(color:Colors.white),)
              ],
            )
        ),
      );
    }else{
      return Container();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Padding(
          padding:EdgeInsets.only(bottom:0,left:0,top:10,right:0),
          child: Material(
            elevation: 8,
            borderOnForeground: false,

            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: (){

                Navigator.popUntil(context, (route){
                  if(route.settings.name != "/home"){
                    Navigator.pushReplacementNamed(context,'/home');
                  }else{
                    Navigator.pop(context);
                  }
                  return true;
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 50,
                child: ClipOval(

                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 150,
                      maxHeight: 150,
                      minWidth: 150,
                      maxWidth: 150
                    ),
                    child: FadeInImage(
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: AssetImage("images/avatar.png"),
                      image: (_imagePath != null )? CachedNetworkImageProvider(_imagePath,) : AssetImage("images/avatar.png"),
                    ),
                  width: 50,
                  height: 50,
                  ),
                ),
              )
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Column(
            children: <Widget>[
              Text(_username, style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
//                Text("UI/Ux Designer",style: TextStyle(color:Colors.white),)
            ],
          )
        ),
        getLoginButton()
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    UserService.getUser().then((User u){

      setState(() {
        _username = u.firstName+' '+u.lastName;
        _imagePath = u.profileImage;
        _userType = u.userType;
      });
    });
  }
}