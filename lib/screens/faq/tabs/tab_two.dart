import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_business/widgets/colors/color_list.dart';

class TabTwo extends StatefulWidget{

  @override
  State createState() {
    return _TabTwoState();
  }
}

class _TabTwoState extends State<TabTwo>{

  final _formKey = GlobalKey<FormState>();

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
              Padding(
                padding: EdgeInsets.fromLTRB(16,16,16,10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Contact No"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter phone / mobile no';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16,16,16,10),
                child: TextFormField(
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
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to show a Snackbar
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
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