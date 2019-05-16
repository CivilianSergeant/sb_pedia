import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/faq.dart';
import 'package:sb_pedia/screens/faq/faq_detail_screen.dart';
import 'package:sb_pedia/services/faq_service.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/list_views/faq_list_item.dart';
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
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool resultExist = false;
  bool hideForm = false;
  List<Faq> searchResults = List<Faq>();
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: _formKey,
        child: Container(
          child: formView(),
        )
    );
  }

  Widget formView(){
    if(!this.hideForm && !this.resultExist) {
      return ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
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
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
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
                  padding: const EdgeInsets.all(0), //16,30,16,16
                  child: RaisedButton(
                      color: ColorList.greenAccentColor,
                      textColor: Colors.white,
                      onPressed: () {
                        final _url = "http://sbes.socialbusinesspedia.com/api/sb_faqs/faq";
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid,
                          final body = {
                            'name': _name.text,
                            'email': _email.text,
                            'question': _message.text,
                            'api_key': 'sb123faq456'
                          };
                          NetworkService.post(_url, body).then((
                              Map<String, dynamic> response) {
                            List searchResult = response['search_result'];
                            if (searchResult.length > 0) {
                              FaqService.getFaqsWhereIdIn(searchResult).then((
                                  List<Faq> suggestedFaqs) {
                                if(suggestedFaqs.length>0) {
                                  setState(() {
                                    this.searchResults = suggestedFaqs;
                                    this.resultExist = true;
                                    this.hideForm = true;
                                    this.itemCount = suggestedFaqs.length;
                                  });
                                }
                              });
                            }
                            if (response['status'] == 200) {
                              Toast.show(response['message'], context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              if (response['message']['duplicate'] != null) {
                                Toast.show(
                                    response['message']['duplicate'], context,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_LONG);
                              }
                            }
                          });
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(0), //5,15,5,15
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text('Submit', style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),),
                          )
                      )
                  ),
                )
              ],
            ),
          )
        ],
      );
    }else{
      return showResult();
    }
  }

  Widget showResult(){
    print(resultExist);
    print(hideForm);
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8),
                    child: Text("FAQ Suggession based on your Inquiry",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Padding(padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: (){
                        setState(() {
                          this.resultExist =false;
                          this.hideForm =false;
                        });
                      },
                      child: Text("New Inquiry"),
                    ),
                  ),


                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: renderItems),
            )
          ],
        ),
      );



  }

  Widget renderItems(BuildContext context, int i) {
    if(searchResults != null) {
      Faq faq = searchResults[i];
       return FaqListItem(
         faq: faq,
         callback: this.triggerAction,
       );
    }
  }

  void triggerAction(Faq faq){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> FaqDetailScreen(title: "FAQ Details",faq: faq,)));
  }
}

class TransparentWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}