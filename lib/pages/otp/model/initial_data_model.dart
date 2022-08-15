import 'dart:convert';

import 'package:wpims/pages/home/model/slider.dart';

InitialData initialDataFromJson(String str) => InitialData.fromJson(json.decode(str));
OtpError otpErrorFromJson(String str) => OtpError.fromJson(json.decode(str));

class OtpError {
  OtpError({
    required this.status,
    required this.message,
  });
  bool status;
  String message;

  factory OtpError.fromJson(Map<String, dynamic> json) => OtpError(
    status: json["status"],
    message: json["message"],
  );
}

String initialDataToJson(InitialData data) => json.encode(data.toJson());

class InitialData {
  InitialData({
    required this.authToken,
    required this.user,
    required this.sliders,
  });

  String authToken;
  User user;
  List<Slider> sliders;

  factory InitialData.fromJson(Map<String, dynamic> json) => InitialData(
    authToken: json["auth_token"],
    user: User.fromJson(json["user"]),
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "auth_token": authToken,
    "user": user.toJson(),
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
  };
}



class User {
  User({
    required this.name,
    required this.mobile,
    required this.image,
    this.email,
  });

  String name;
  String mobile;
  String image;
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    mobile: json["mobile"],
    image: json["image"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "image": image,
    "email": email,
  };
}
