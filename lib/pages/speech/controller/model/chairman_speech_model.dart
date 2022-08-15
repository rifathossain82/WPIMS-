// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ChairmanSpeechApi chairmanSpeechFromJson(String str) => ChairmanSpeechApi.fromJson(json.decode(str));

String chairmanSpeechToJson(ChairmanSpeechApi data) => json.encode(data.toJson());

class ChairmanSpeechApi {
  ChairmanSpeechApi({
    required this.status,
    required this.message,
  });

  bool status;
  Message message;

  factory ChairmanSpeechApi.fromJson(Map<String, dynamic> json) => ChairmanSpeechApi(
    status: json["status"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message.toJson(),
  };
}

class Message {
  Message({
    required this.name,
    required this.quote,
    required this.designation,
    this.image,
  });

  String name;
  String quote;
  String designation;
  String? image;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    name: json["name"],
    quote: json["quote"],
    designation: json["designation"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quote": quote,
    "designation": designation,
    "image": image,
  };
}
