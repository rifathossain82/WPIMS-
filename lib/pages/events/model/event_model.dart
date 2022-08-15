// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

EventDetailsApi eventDetailsFromJson(String str) => EventDetailsApi.fromJson(json.decode(str));

String eventDetailsToJson(EventDetailsApi data) => json.encode(data.toJson());

class EventDetailsApi {
  EventDetailsApi({
    required this.status,
    required this.event,
  });

  bool status;
  EventDetailsModel event;

  factory EventDetailsApi.fromJson(Map<String, dynamic> json) => EventDetailsApi(
    status: json["status"],
    event: EventDetailsModel.fromJson(json["event"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "event": event.toJson(),
  };
}

class EventDetailsModel {
  EventDetailsModel({
    required this.title,
    required this.body,
    required this.date,
    this.location,
    required this.image,
  });

  String title;
  String body;
  String date;
  String? location;
  String image;

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) => EventDetailsModel(
    title: json["title"],
    body: json["body"],
    date: json["date"],
    location: json["location"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "date": date,
    "location": location,
    "image": image,
  };
}
