// To parse this JSON data, do
//
//     final calender = calenderFromJson(jsonString);

import 'dart:convert';

CalendarApi calenderFromJson(String str) => CalendarApi.fromJson(json.decode(str));

String calenderToJson(CalendarApi data) => json.encode(data.toJson());

class CalendarApi {
  CalendarApi({
    required this.calendar,
  });

  List<CalendarModel> calendar;

  factory CalendarApi.fromJson(Map<String, dynamic> json) => CalendarApi(
    calendar: List<CalendarModel>.from(json["calendar"].map((x) => CalendarModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "calendar": List<dynamic>.from(calendar.map((x) => x.toJson())),
  };
}

class CalendarModel {
  CalendarModel({
    required this.id,
    required this.month,
    required this.events,
  });

  int id;
  String month;
  List<Event> events;

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
    id: json["id"],
    month: json["month"],
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "month": month,
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    required this.date,
    required this.day,
    required this.title,
  });

  String date;
  String day;
  String title;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    date: json["date"],
    day: json["day"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "day": day,
    "title": title,
  };
}
