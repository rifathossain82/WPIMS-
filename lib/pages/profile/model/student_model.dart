// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

StudentProfileApi studentProfileFromJson(String str) => StudentProfileApi.fromJson(json.decode(str));

String studentProfileToJson(StudentProfileApi data) => json.encode(data.toJson());

class StudentProfileApi {
  StudentProfileApi({
    required this.status,
    required this.student,
  });

  bool status;
  StudentProfileModel student;

  factory StudentProfileApi.fromJson(Map<String, dynamic> json) => StudentProfileApi(
    status: json["status"],
    student: StudentProfileModel.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "student": student.toJson(),
  };
}

class StudentProfileModel {
  StudentProfileModel({
    required this.personal,
    required this.father,
    required this.mother,
    required this.address,
  });

  Personal personal;
  Ther father;
  Ther mother;
  Address address;

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) => StudentProfileModel(
    personal: Personal.fromJson(json["personal"]),
    father: Ther.fromJson(json["father"]),
    mother: Ther.fromJson(json["mother"]),
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "personal": personal.toJson(),
    "father": father.toJson(),
    "mother": mother.toJson(),
    "address": address.toJson(),
  };
}

class Address {
  Address({
    required this.city,
    required this.country,
    required this.postcode,
    required this.address,
  });

  String city;
  String country;
  String postcode;
  String address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    country: json["country"],
    postcode: json["postcode"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "postcode": postcode,
    "address": address,
  };
}

class Ther {
  Ther({
    required this.name,
    required this.mobile,
    required this.occupation,
  });

  String name;
  String mobile;
  String occupation;

  factory Ther.fromJson(Map<String, dynamic> json) => Ther(
    name: json["name"],
    mobile: json["mobile"],
    occupation: json["occupation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "occupation": occupation,
  };
}

class Personal {
  Personal({
    required this.name,
    required this.studentId,
    this.picture,
    required this.personalClass,
    required this.rank,
    required this.status,
    required this.dob,
    required this.blood,
    required this.religion,
    required this.nationality,
    required this.mobile,
    required this.email,
  });

  String name;
  String studentId;
  String? picture;
  String personalClass;
  String rank;
  String status;
  String dob;
  String blood;
  String religion;
  String nationality;
  String mobile;
  String email;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    name: json["name"],
    studentId: json["student_id"],
    picture: json["picture"],
    personalClass: json["class"],
    rank: json["rank"],
    status: json["status"],
    dob: json["dob"],
    blood: json["blood"],
    religion: json["religion"],
    nationality: json["nationality"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "student_id": studentId,
    "picture": picture,
    "class": personalClass,
    "rank": rank,
    "status": status,
    "dob": dob,
    "blood": blood,
    "religion": religion,
    "nationality": nationality,
    "mobile": mobile,
    "email": email,
  };
}
