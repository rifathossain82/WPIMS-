// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

EventListApi eventsFromJson(String str) => EventListApi.fromJson(json.decode(str));

String eventsToJson(EventListApi data) => json.encode(data.toJson());

class EventListApi {
  EventListApi({
    required this.status,
    required this.events,
    required this.links,
    required this.meta,
  });

  bool status;
  List<EventModel> events;
  Links links;
  Meta meta;

  factory EventListApi.fromJson(Map<String, dynamic> json) => EventListApi(
    status: json["status"],
    events: List<EventModel>.from(json["events"].map((x) => EventModel.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}


class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}

class EventModel {
  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.image,
    required this.location,
  });

  int id;
  String title;
  String date;
  String image;
  String location;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    image: json["image"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "image": image,
    "location": location,
  };
}
