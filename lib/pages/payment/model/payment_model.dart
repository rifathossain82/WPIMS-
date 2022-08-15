// To parse this JSON data, do
//
//     final paymentList = paymentListFromJson(jsonString);

import 'dart:convert';

PaymentList paymentListFromJson(String str) => PaymentList.fromJson(json.decode(str));

String paymentListToJson(PaymentList data) => json.encode(data.toJson());

class PaymentList {
  PaymentList({
    required this.years,
    required this.payments,
    required this.due,
  });

  List<YearModel> years;
  List<PaymentModel> payments;
  String due;

  factory PaymentList.fromJson(Map<String, dynamic> json) => PaymentList(
    years: List<YearModel>.from(json["years"].map((x) => YearModel.fromJson(x))),
    payments: List<PaymentModel>.from(json["payments"].map((x) => PaymentModel.fromJson(x))),
    due: json["due"],
  );

  Map<String, dynamic> toJson() => {
    "years": List<dynamic>.from(years.map((x) => x.toJson())),
    "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
    "due": due,
  };
}

class PaymentModel {
  PaymentModel({
    required this.month,
    required this.due,
    required this.paid,
  });

  String month;
  String due;
  String paid;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    month: json["month"],
    due: json["due"],
    paid: json["paid"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "due": due,
    "paid": paid,
  };
}

class YearModel {
  YearModel({
    required this.label,
    required this.value,
  });

  String label;
  String value;

  factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
