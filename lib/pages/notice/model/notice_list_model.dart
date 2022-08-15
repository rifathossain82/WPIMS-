import 'dart:convert';

NoticeListApi noticeFromJson(String str) => NoticeListApi.fromJson(json.decode(str));

String noticeToJson(NoticeListApi data) => json.encode(data.toJson());


class NoticeListApi {
  NoticeListApi({
    required this.status,
    required this.notices,
    this.message,
    required this.links,
    required this.meta,
  });

  bool status;
  String? message;
  List<NoticeModel> notices;
  Links links;
  Meta meta;

  factory NoticeListApi.fromJson(Map<String, dynamic> json) => NoticeListApi(
    status: json["status"],
    notices: List<NoticeModel>.from(json["notices"].map((x) => NoticeModel.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message ?? null,
    "notices": List<dynamic>.from(notices.map((x) => x.toJson())),
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

class NoticeModel {
  NoticeModel({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    this.type,
  });

  int id;
  String title;
  String date;
  String category;
  String? type;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    category: json["category"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "category": category,
    "type": type,
  };
}
