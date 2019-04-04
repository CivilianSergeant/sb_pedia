import 'package:flutter/material.dart';

class NavDrawerHeader extends StatelessWidget{

  String imagePath;
  Color color;

  NavDrawerHeader({Key key, this.color,this.imagePath});

  @override
  Widget build(BuildContext context) {

    return DrawerHeader(

      child: Column(

        children: <Widget>[
          Padding(
            padding:EdgeInsets.only(bottom:0,left:0,top:8,right:0),
            child: Material(
              elevation: 8,
              borderOnForeground: false,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: (){

                  Navigator.popUntil(context, (route){
                    if(route.settings.name != "/home"){
                      Navigator.popAndPushNamed(context,'/home');
                    }else{
                      Navigator.pop(context);
                    }
                    return true;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xffffffff),
                  radius: 50,
                  backgroundImage: AssetImage(imagePath),
                )
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Column(
              children: <Widget>[
                Text("Atahar Sharif", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                Text("UI/Ux Designer",style: TextStyle(color:Colors.white),)
              ],
            )

          )
        ],
      ),
      decoration: BoxDecoration(
        color: color,
        border: new Border.all(color: Colors.transparent)
      ),
    );
  }
}