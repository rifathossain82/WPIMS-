
import 'dart:convert';

LoginResponseModel loginResponseFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
LoginError loginErrorFromJson(String str) => LoginError.fromJson(json.decode(str));
String loginResponseToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

class LoginError {
  LoginError({
    required this.status,
    required this.message,
  });
  bool status;
  String message;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
    status: json["status"],
    message: json["message"],
  );
}