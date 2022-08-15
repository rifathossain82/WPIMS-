import 'dart:convert';

Sliders slidersFromJson(String str) => Sliders.fromJson(json.decode(str));

String slidersToJson(Sliders data) => json.encode(data.toJson());

class Sliders {
  Sliders({
    required this.sliders,
  });

  List<Slider> sliders;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
  };
}

class Slider {
  Slider({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}