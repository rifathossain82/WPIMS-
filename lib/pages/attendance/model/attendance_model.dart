import 'dart:convert';

AttendanceListApi attendanceListFromJson(String str) => AttendanceListApi.fromJson(json.decode(str));

String attendanceListToJson(AttendanceListApi data) => json.encode(data.toJson());

class AttendanceListApi {
  AttendanceListApi({
    required this.status,
    required this.today,
    required this.dateFrom,
    required this.dateTo,
    required this.shiftFrom,
    required this.shiftTo,
    required this.attendances,
  });

  bool status;
  Today today;
  String dateFrom;
  String dateTo;
  String shiftFrom;
  String shiftTo;
  List<AttendanceModel> attendances;

  factory AttendanceListApi.fromJson(Map<String, dynamic> json) => AttendanceListApi(
    status: json["status"],
    today: Today.fromJson(json["today"]),
    dateFrom: json["dateFrom"],
    dateTo: json["dateTo"],
    shiftFrom: json["shiftFrom"],
    shiftTo: json["shiftTo"],
    attendances: List<AttendanceModel>.from(json["attendances"].map((x) => AttendanceModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "today": today.toJson(),
    "dateFrom": dateFrom,
    "dateTo": dateTo,
    "shiftFrom": shiftFrom,
    "shiftTo": shiftTo,
    "attendances": List<dynamic>.from(attendances.map((x) => x.toJson())),
  };
}

class AttendanceModel {
  AttendanceModel({
    required this.id,
    required this.date,
    this.inTime,
    this.outTime,
    required this.status,
  });

  int id;
  String date;
  String? inTime;
  String? outTime;
  String status;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    id: json["id"],
    date: json["date"],
    inTime: json["inTime"],
    outTime: json["outTime"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toString(),
    "inTime": inTime,
    "outTime": outTime,
    "status": status,
  };
}

class Today {
  Today({
    required this.date,
    this.inTime,
    this.outTime,
    required this.status,
  });

  String date;
  String? inTime;
  String? outTime;
  String status;

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    date: json["date"],
    inTime: json["inTime"],
    outTime: json["outTime"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "inTime": inTime,
    "outTime": outTime,
    "status": status,
  };
}

