// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TeacherListApi teacherListFromJson(String str) => TeacherListApi.fromJson(json.decode(str));

String teacherListToJson(TeacherListApi data) => json.encode(data.toJson());

class TeacherListApi {
  TeacherListApi({
    required this.status,
    required this.teachers,
    required this.links,
    required this.meta,
  });

  bool status;
  List<Teacher> teachers;
  Links links;
  Meta meta;

  factory TeacherListApi.fromJson(Map<String, dynamic> json) => TeacherListApi(
    status: json["status"],
    teachers: List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "teachers": List<dynamic>.from(teachers.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}

class Teacher {
  Teacher({
    required this.name,
    required this.designation,
    required this.phone,
    required this.empNo,
    required this.joiningDate,
    this.email,
    this.image,
    this.gender,
    this.bloodGroup,
  });

  String name;
  String designation;
  String phone;
  String empNo;
  String joiningDate;
  String? email;
  String? image;
  String? gender;
  String? bloodGroup;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    name: json["name"],
    designation: json["designation"],
    phone: json["phone"],
    empNo: json["empNo"],
    joiningDate: json["joiningDate"],
    email: json["email"],
    image: json["image"],
    gender: json["gender"],
    bloodGroup: json["bloodGroup"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "designation": designation,
    "phone": phone,
    "empNo": empNo,
    "joiningDate": joiningDate,
    "email": email,
    "image": image,
    "gender": gender,
    "bloodGroup": bloodGroup,
  };
}
