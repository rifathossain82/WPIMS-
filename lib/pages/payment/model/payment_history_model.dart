import 'dart:convert';

PaymentHistoryList paymentHistoryFromJson(String str) => PaymentHistoryList.fromJson(json.decode(str));

String paymentHistoryToJson(PaymentHistoryList data) => json.encode(data.toJson());

class PaymentHistoryList {
  PaymentHistoryList({
    required this.history,
    required this.total,
  });

  List<PaymentHistoryModel> history;
  String total;

  factory PaymentHistoryList.fromJson(Map<String, dynamic> json) => PaymentHistoryList(
    history: List<PaymentHistoryModel>.from(json["history"].map((x) => PaymentHistoryModel.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
    "total": total,
  };
}

class PaymentHistoryModel {
  PaymentHistoryModel({
    required this.date,
    required this.method,
    required this.amount,
  });

  String date;
  String method;
  String amount;

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    date: json["date"],
    method: json["method"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "method": method,
    "amount": amount,
  };
}

