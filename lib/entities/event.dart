class Event {

  final int id;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String eventId;
  final String title;
  final String eventCode;
  final String venue;
  final String city;
  final String bannerImage;
  final String status;
  final String eventScheduleId;
  final bool description;
  final int orderId;
  final String contentUrl;
  final String type;
  final String photo;

  Event({this.id,this.startDate,this.startTime,this.endDate,this.endTime,
  this.eventId,this.title,this.eventCode,this.venue,this.city,this.bannerImage,
  this.status,this.eventScheduleId,this.description,this.orderId,
  this.contentUrl,this.type,this.photo});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: int.parse(json['id']),
      startDate: json['start_date'],
      startTime: json['start_time'],
      endDate: json['end_date'],
      endTime: json['end_time'],
      eventId: json['eventid'],
      title: json['title'],
      eventCode: json['event_code'],
      venue: json['venue'],
      city: json['city'],
      bannerImage: json['banner_image'],
      status: json['status'],
      eventScheduleId: json['event_schedule_id'],
      description: false,
      orderId: 0,
      contentUrl: json['content_url'],
      type: json['type'],
      photo: json['photo']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'start_date' : startDate,
      'start_time' : startTime,
      'end_date' : endDate,
      'end_time' : endTime,
      'venue': venue
    };
  }
}