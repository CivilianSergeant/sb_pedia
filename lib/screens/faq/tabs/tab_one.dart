import 'package:flutter/material.dart';
import 'package:social_business/screens/faq/faq_detail_screen.dart';
import 'package:social_business/widgets/list_views/faq_list_item.dart';
class TabOne extends StatefulWidget{

  @override
  State createState() {
    return _TabOneState();
  }
}
class _TabOneState extends State<TabOne>{
  List _faqCategories =
  ["Category-01", "Category-02", "Category-03", "Category-04", "Category-05"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedValue;


  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedValue = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String faq in _faqCategories) {
      items.add(new DropdownMenuItem(
          value: faq,
          child: new Text(faq)
      ));
    }
    return items;
  }

  void triggerAction(){
      Navigator.push(context,MaterialPageRoute(builder: (context)=> FaqDetailScreen(title: "FAQ Details",)));
  }

  Widget build(BuildContext context){
    return
      Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10,8,10,8),
              child: Row(
                children: <Widget>[
                  Text("Select Category: ",style: TextStyle(fontSize: 18,color: Colors.black87),),
                  DropdownButton(
                    value: _selectedValue,
                    items: _dropDownMenuItems,
                    onChanged: (String selectedValue){
                      setState(() {
                        _selectedValue = selectedValue;
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  FaqListItem(
                    text: "How to create an account?",
                    callback: this.triggerAction,
                  ),
                  FaqListItem(
                    text: "How can you update organization profile information?",
                    callback: this.triggerAction,),
                ],
              ),
            )
          ],
        ),
      );
  }
}