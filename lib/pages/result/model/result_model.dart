import 'dart:convert';

ResultListApi resultListApiFromJson(String str) => ResultListApi.fromJson(json.decode(str));

String resultListApiToJson(ResultListApi data) => json.encode(data.toJson());

class ResultListApi {
  ResultListApi({
    required this.status,
    required this.results,
  });

  bool status;
  List<ResultListModel> results;

  factory ResultListApi.fromJson(Map<String, dynamic> json) => ResultListApi(
    status: json["status"],
    results: List<ResultListModel>.from(json["results"].map((x) => ResultListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultListModel {
  ResultListModel({
    required this.id,
    required this.title,
    required this.isPassed,
    required this.result,
  });

  int id;
  String title;
  bool isPassed;
  List<ResultModel> result;

  factory ResultListModel.fromJson(Map<String, dynamic> json) => ResultListModel(
    id: json["id"],
    title: json["title"],
    isPassed: json["isPassed"],
    result: List<ResultModel>.from(json["result"].map((x) => ResultModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "isPassed": isPassed,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultModel {
  ResultModel({
    required this.label,
    required this.obtained,
    required this.total,
  });

  String label;
  String obtained;
  String total;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    label: json["label"],
    obtained: json["obtained"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "obtained": obtained,
    "total": total,
  };
}


class Marks{
  String label;
  String obtained;
  String total;
  Marks({
    required this.label,
    required this.obtained,
    required this.total
  });
}

