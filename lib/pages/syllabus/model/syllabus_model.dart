import 'dart:convert';

SyllabusModel syllabusModelFromJson(String str) => SyllabusModel.fromJson(json.decode(str));

String syllabusModelToJson(SyllabusModel data) => json.encode(data.toJson());

class SyllabusModel {
  SyllabusModel({
    required this.status,
    required this.file,
  });

  bool status;
  String file;

  factory SyllabusModel.fromJson(Map<String, dynamic> json) => SyllabusModel(
    status: json["status"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "file": file,
  };
}
