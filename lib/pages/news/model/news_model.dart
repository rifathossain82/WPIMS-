import 'dart:convert';

NewsDetailsApi newsDetailsFromJson(String str) => NewsDetailsApi.fromJson(json.decode(str));

String newsDetailsToJson(NewsDetailsApi data) => json.encode(data.toJson());

class NewsDetailsApi {
  NewsDetailsApi({
    required this.status,
    required this.news,
    this.message,
  });

  bool status;
  NewsDetailsModel news;
  String? message;

  factory NewsDetailsApi.fromJson(Map<String, dynamic> json) => NewsDetailsApi(
    status: json["status"],
    message: json["message"],
    news: NewsDetailsModel.fromJson(json["news"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "news": news.toJson(),
    "message": message ?? null,
  };
}

class NewsDetailsModel {
  NewsDetailsModel({
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

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
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