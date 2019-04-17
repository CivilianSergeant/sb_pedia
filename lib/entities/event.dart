class Event {

  static const String table = "events";

  final int id;
  final String title;
  final String venue;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String eventCode;
  final String eventScheduleId;
  final String contentUrl;
  final String city;
  final String image;
  final String type;

  Event({
    this.id,
    this.title,
    this.venue,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.city,
    this.image,
    this.type,
    this.eventCode,
    this.eventScheduleId,
    this.contentUrl
  });

  factory Event.fromJson(Map<String, dynamic> json) {

    return Event(
      id: int.parse(json['id']),
      title: json['title'],
      venue: json['venue'],
      startDate: json['start_date'],
      startTime: json['start_time'],
      endDate: json['end_date'],
      endTime: json['end_time'],
      city: json['city'],
      image: json['image'],
      type: json['type'],
      eventCode: json['event_code'],
      eventScheduleId: json['event_schedule_id'],
      contentUrl: json['content_url']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'venue': venue,
      'start_date' : startDate,
      'start_time' : startTime,
      'end_date' : endDate,
      'end_time' : endTime,
      'event_code' : eventCode,
      'event_schedule_id' : eventScheduleId,
      'content_url' : contentUrl,
      'city' : city,
      'image' : image,
      'type' : type
    };
  }
}