import 'dart:convert';

AgentReportMonthlyResponse agentReportMonthlyResponseFromJson(String str) => AgentReportMonthlyResponse.fromJson(json.decode(str));

class AgentReportMonthlyResponse {
  AgentReportMonthlyResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Data>? data;

  factory AgentReportMonthlyResponse.fromJson(Map<String, dynamic> json) => AgentReportMonthlyResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );
}

class Data {
  Data({
    this.monthQty,
    this.monthValue,
    this.finalDisbursedAmount,
    this.status,
  });

  int? monthQty;
  double? monthValue;
  int? finalDisbursedAmount;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    monthQty: json["month_qty"] == null ? null : json["month_qty"],
    monthValue: json["month_value"] == null ? null : json["month_value"].toDouble(),
    finalDisbursedAmount: json["final_disbursed_amount"] == null ? null : json["final_disbursed_amount"],
    status: json["status"] == null ? null : json["status"],
  );
}
