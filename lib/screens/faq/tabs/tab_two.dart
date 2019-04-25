import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:toast/toast.dart';

class TabTwo extends StatefulWidget{

  @override
  State createState() {
    return _TabTwoState();
  }
}

class _TabTwoState extends State<TabTwo>{

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
//  final _contactNo = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16,16,16,10),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: "Name"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                  },
                ),
              ),
//              Padding(
//                padding: EdgeInsets.fromLTRB(16,16,16,10),
//                child: TextFormField(
//                  controller: _contactNo,
//                  decoration: InputDecoration(
//                      hintText: "Contact No"
//                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter phone / mobile no';
//                    }
//                  },
//                ),
//              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16,16,16,10),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16,16,16,10),
                child: TextFormField(
                  controller: _message,
                  keyboardType: TextInputType.multiline,
                  maxLength: 250,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Message"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Message';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16,30,16,16),
                child: RaisedButton(
                  color: ColorList.greenAccentColor,
                  textColor: Colors.white,
                  onPressed: () {
                    final _url = "http://sbes.socialbusinesspedia.com/api/sb_faqs/faq";
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to show a Snackbar
                      print(_name.text);

                      print(_email.text);
                      print(_message.text);
                      final body = {
                        'name' : _name.text,
                        'email' : _email.text,
                        'question' : _message.text,
                        'api_key': 'sb123faq456'
                      };
                      NetworkService.post(_url, body).then((Map<String,dynamic> response){
                        if(response['status'] == 200){
                          Toast.show(response['message'], context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }else{
                          if(response['message']['duplicate'] != null) {
                            Toast.show(
                                response['message']['duplicate'], context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          }
                        }
                      });
//                      Scaffold.of(context)
//                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5,15,5,15),
                    child: Text('Submit',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  )
                ),
              )
            ],
          ),
        ),

    );
  }
}