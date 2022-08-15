import 'dart:convert';

AboutApi aboutFromJson(String str) => AboutApi.fromJson(json.decode(str));

String aboutToJson(AboutApi data) => json.encode(data.toJson());

class AboutApi {
  AboutApi({
    required this.status,
    required this.about,
    this.image,
  });

  bool status;
  String about;
  String? image;

  factory AboutApi.fromJson(Map<String, dynamic> json) => AboutApi(
    status: json["status"],
    about: json["about"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "about": about,
    "image": image,
  };
}
