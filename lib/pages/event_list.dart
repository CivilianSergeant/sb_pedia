import 'package:flutter/material.dart';
import 'package:flutter_demo/app_bar/app_bar.dart';
import 'package:flutter_demo/colors/color_list.dart';
import 'package:flutter_demo/entities/event.dart';
import 'package:flutter_demo/list_views/event_list_item.dart';
import 'package:flutter_demo/navigation_drawer/navigation_drawer.dart';
import 'package:flutter_demo/services/event_service.dart';

class Events extends StatelessWidget{

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
      return EventListItem(
        title: event.title,
        start: ((event.startDate != null) ? event.startDate : "N/A"),
        end: ((event.endDate != null) ? event.endDate : "N/A"),
        venue: ((event.venue != null) ? event.venue : "N/A"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var appTitleBar = AppTitleBar(title: 'All Event List', backgroundColor: ColorList.greenColor);

    return WillPopScope(
      onWillPop: () async {

        Navigator.pushReplacementNamed(context, "/home");
      },
      child: Scaffold(
          appBar: appTitleBar.build(),
          drawer: NavigationDrawer(color:ColorList.greenColor,accentColor:ColorList.greenAccentColor,),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: renderItems,
            ),
            onRefresh: () async {

              if(!onLoadFlag){
                onLoadFlag=true;
                return EventService.events().then((dynamic lists){
                  if(lists != null) {
                    setState(() {
                      itemCount = lists.length;
                      events = lists;

                    });
                  }
                });

              } else {
                return EventService.getEventsFromApi().then( (dynamic lists) {
                if(lists != null) {
                  for(var i=0;i<lists.length; i++){
                    Event event = lists[i];
                    EventService.addEvent(event);
                  }
                  setState(() {
                    itemCount = lists.length;
                    events = lists;
                  });
                }
              });
              }
            },
          )
      ),
    );
  }


}

