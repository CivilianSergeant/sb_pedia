import 'package:flutter/material.dart';
import 'package:sb_pedia/entities/category.dart';
import 'package:sb_pedia/entities/faq.dart';
import 'package:sb_pedia/screens/faq/faq_detail_screen.dart';
import 'package:sb_pedia/services/category_service.dart';
import 'package:sb_pedia/services/faq_service.dart';
import 'package:sb_pedia/widgets/colors/color_list.dart';
import 'package:sb_pedia/widgets/list_views/faq_list_item.dart';
class TabOne extends StatefulWidget{

  @override
  State createState() {
    return _TabOneState();
  }
}

class _TabOneState extends State<TabOne>{

  List<DropdownMenuItem<String>> _dropDownMenuItems = List();
  String _selectedValue;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorState;
  List<Faq> _allFaqs;
  int _itemCount=0;

  @override
  void initState() {
    super.initState();
    _refreshIndicatorState = new GlobalKey<RefreshIndicatorState>();
    loadCategories();
  }

  Future<void> loadCategories() async {
    Future.delayed(Duration(milliseconds: 200),(){
      CategoryService.getCategories().then((List<Category> _faqCategories){
        for(Category category in _faqCategories){
          //setState(() {
            _dropDownMenuItems.add(DropdownMenuItem(
                value: category.id.toString(),
                child: new Text(category.name + " (" + category.totalFaq.toString() + ")")
            ));

//          });
        }
        setState(() {
          _selectedValue = _dropDownMenuItems[0].value;

        });
      });
      _refreshIndicatorState.currentState?.show();
    });
  }

  Future<bool> _loadFaqByCategory({String categoryId}) async {

    List<Faq> allFaqs = await FaqService.getFaqs(catId: categoryId);

    setState(() {
      _selectedValue = categoryId;
      if(allFaqs != null){
        _itemCount = allFaqs.length;
        _allFaqs = allFaqs;
      }
    });
    return Future.value(false);
  }

  Widget renderItems(BuildContext context, int i) {
    if(_allFaqs != null) {
      Faq faq = _allFaqs[i];
      return FaqListItem(
        faq: faq,
        callback: this.triggerAction,
      );
    }
  }

  void triggerAction(Faq faq){
      Navigator.push(context,MaterialPageRoute(builder: (context)=> FaqDetailScreen(title: "FAQ Details",faq: faq,)));
  }

  Widget build(BuildContext context){
    return
      Container(
        color: ColorList.home,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10,8,10,8),
              child: Row(
                children: <Widget>[

                  DropdownButton(
                    value: _selectedValue,
                    items: _dropDownMenuItems,
                    onChanged: (String selectedValue){
                      _loadFaqByCategory(categoryId: selectedValue);
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorState,
                child: ListView.builder(
                    itemCount: _itemCount,
                    itemBuilder: renderItems
                ),
                onRefresh: (){
                  return _loadFaqByCategory(categoryId: _selectedValue);
                },
              ),
            )
          ],
        ),
      );
  }
}