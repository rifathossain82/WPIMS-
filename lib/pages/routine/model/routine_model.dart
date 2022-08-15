
import 'dart:convert';

RoutineListApi routineApiFromJson(String str) => RoutineListApi.fromJson(json.decode(str));

String routineApiToJson(RoutineListApi data) => json.encode(data.toJson());

class RoutineListApi {
  RoutineListApi({
    required this.status,
    required this.routine,
  });

  bool status;
  List<RoutineModel> routine;

  factory RoutineListApi.fromJson(Map<String, dynamic> json) => RoutineListApi(
    status: json["status"],
    routine: List<RoutineModel>.from(json["routine"].map((x) => RoutineModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "routine": List<dynamic>.from(routine.map((x) => x.toJson())),
  };
}

class RoutineModel {
  RoutineModel({
    required this.id,
    required this.weekday,
    required this.hours,
  });

  int id;
  String weekday;
  List<RoutineHour> hours;

  factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel(
    id: json["id"],
    weekday: json["weekday"],
    hours: List<RoutineHour>.from(json["hours"].map((x) => RoutineHour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekday": weekday,
    "hours": List<dynamic>.from(hours.map((x) => x.toJson())),
  };
}

class RoutineHour {
  RoutineHour({
    required this.name,
    required this.start,
    required this.end,
    required this.subject,
    required this.isBreak,
  });

  String name;
  String start;
  String end;
  String subject;
  bool isBreak;

  factory RoutineHour.fromJson(Map<String, dynamic> json) => RoutineHour(
    name: json["name"],
    start: json["start"],
    end: json["end"],
    subject: json["subject"],
    isBreak: json["isBreak"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "start": start,
    "end": end,
    "subject": subject,
    "isBreak": isBreak,
  };
}
