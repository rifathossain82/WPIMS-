import 'dart:convert';

NoticeDetailsApi noticeDetailsFromJson(String str) => NoticeDetailsApi.fromJson(json.decode(str));

String noticeDetailsToJson(NoticeDetailsApi data) => json.encode(data.toJson());

class NoticeDetailsApi {
  NoticeDetailsApi({
    required this.status,
    required this.notice,
    this.message,
  });

  bool status;
  NoticeDetailsModel notice;
  String? message;

  factory NoticeDetailsApi.fromJson(Map<String, dynamic> json) => NoticeDetailsApi(
    status: json["status"],
    message: json["message"],
    notice: NoticeDetailsModel.fromJson(json["notice"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notice": notice.toJson(),
    "message": message ?? null,
  };
}

class NoticeDetailsModel {
  NoticeDetailsModel({
    required this.title,
    required this.date,
    required this.body,
    required this.category,
    this.type,
    this.image,
  });

  String title;
  String date;
  String body;
  String category;
  String? type;
  String? image;

  factory NoticeDetailsModel.fromJson(Map<String, dynamic> json) => NoticeDetailsModel(
    title: json["title"],
    date: json["date"],
    body: json["body"],
    category: json["category"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "date": date,
    "body": body,
    "category": category,
    "type": type,
    "image": image,
  };
}