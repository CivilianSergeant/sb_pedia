import 'package:flutter/material.dart';
import 'package:social_business/widgets/app_bar/app_bar.dart';
import 'package:social_business/widgets/colors/color_list.dart';
import 'package:social_business/entities/event.dart';
import 'package:social_business/widgets/list_views/event_list_item.dart';
import 'package:social_business/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:social_business/services/event_service.dart';

class EventScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return EventList();
  }
}

class EventList extends StatefulWidget{

  @override
  State createState() {
    return EventListState();
  }
}

class EventListState extends State<EventList>{

  dynamic events;
  int itemCount = 0;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  bool onLoadFlag = false;

  @override
  void initState() {
    super.initState();
    onLoadFlag = false;
    _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }



  Widget renderItems(BuildContext context, int i) {
    if(events != null) {
      Event event = events[i];
      return EventListItem(event: event);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appTitleBar = AppTitleBar(title: 'All Event List', backgroundColor: ColorList.greenColor);

    return WillPopScope(
      onWillPop: (){

        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
        appBar: appTitleBar.build(),
        drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: renderItems,
            ),
          ),
          onRefresh: () async {

            if(!onLoadFlag){
              onLoadFlag=true;
              return EventService.getEvents().then((dynamic lists){
                if(lists != null) {
                  setState(() {
                    itemCount = lists.length;
                    events = lists;

                  });
                }
              });

            } else {
//              return EventService.getEventsFromApi().then( (dynamic lists) {
//              if(lists != null) {
//                for(var i=0;i<lists.length; i++){
//                  Event event = lists[i];
//                  EventService.addEvent(event);
//                }
//                setState(() {
//                  itemCount = lists.length;
//                  events = lists;
//                });
//              }
//            });
            }
          },
        )
      ),
    );
  }


}
