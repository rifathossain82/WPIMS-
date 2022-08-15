import 'dart:convert';

DiaryListApi diaryListFromJson(String str) => DiaryListApi.fromJson(json.decode(str));

String diaryListToJson(DiaryListApi data) => json.encode(data.toJson());

class DiaryListApi {
  DiaryListApi({
    required this.status,
    required this.date,
    required this.weekDay,
    required this.diaries,
  });

  bool status;
  String date;
  String weekDay;
  List<DiaryModel> diaries;

  factory DiaryListApi.fromJson(Map<String, dynamic> json) => DiaryListApi(
    status: json["status"],
    date: json["date"],
    weekDay: json["weekDay"],
    diaries: List<DiaryModel>.from(json["diaries"].map((x) => DiaryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": date,
    "weekDay": weekDay,
    "diaries": List<dynamic>.from(diaries.map((x) => x.toJson())),
  };
}

class DiaryModel {
  DiaryModel({
    required this.id,
    required this.subject,
    required this.diary,
  });

  int id;
  String subject;
  String diary;

  factory DiaryModel.fromJson(Map<String, dynamic> json) => DiaryModel(
    id: json["id"],
    subject: json["subject"],
    diary: json["diary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "diary": diary,
  };
}
