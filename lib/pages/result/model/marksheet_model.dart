// To parse this JSON data, do
//
//     final marksheet = marksheetFromJson(jsonString);

import 'dart:convert';

MarksheetApi marksheetFromJson(String str) => MarksheetApi.fromJson(json.decode(str));

String marksheetToJson(MarksheetApi data) => json.encode(data.toJson());

class MarksheetApi {
  MarksheetApi({
    required this.status,
    required this.examName,
    required this.marksheet,
  });

  bool status;
  String examName;
  List<MarkSheetModel> marksheet;

  factory MarksheetApi.fromJson(Map<String, dynamic> json) => MarksheetApi(
    status: json["status"],
    examName: json["examName"],
    marksheet: List<MarkSheetModel>.from(json["marksheet"].map((x) => MarkSheetModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "examName": examName,
    "marksheet": List<dynamic>.from(marksheet.map((x) => x.toJson())),
  };
}

class MarkSheetModel {
  MarkSheetModel({
    required this.title,
    required this.isPassed,
    required this.total,
    required this.marks,
  });

  String title;
  bool isPassed;
  String total;
  List<Grade> marks;

  factory MarkSheetModel.fromJson(Map<String, dynamic> json) => MarkSheetModel(
    title: json["title"],
    isPassed: json["isPassed"],
    total: json["total"],
    marks: List<Grade>.from(json["marks"].map((x) => Grade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "isPassed": isPassed,
    "total": total,
    "marks": List<dynamic>.from(marks.map((x) => x.toJson())),
  };
}

class Grade {
  Grade({
    required this.label,
    required this.obtained,
    required this.total,
    required this.pass,
    required this.highest,
  });

  String label;
  String obtained;
  String total;
  String pass;
  String highest;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
    label: json["label"],
    obtained: json["obtained"],
    total: json["total"],
    pass: json["pass"],
    highest: json["highest"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "obtained": obtained,
    "total": total,
    "pass": pass,
    "highest": highest,
  };
}



