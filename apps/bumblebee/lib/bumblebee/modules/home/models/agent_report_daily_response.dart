import 'dart:convert';

AgentReportDailyResponse agentReportDailyResponseFromJson(String str) => AgentReportDailyResponse.fromJson(json.decode(str));

class AgentReportDailyResponse {
  AgentReportDailyResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Data>? data;

  factory AgentReportDailyResponse.fromJson(Map<String, dynamic> json) => AgentReportDailyResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );
}

class Data {
  Data({
    this.dayQty,
    this.dayValue,
    this.finalDisbursedAmount,
    this.status,
  });

  int? dayQty;
  double? dayValue;
  int? finalDisbursedAmount;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dayQty: json["day_qty"] == null ? null : json["day_qty"],
    dayValue: json["day_value"] == null ? null : json["day_value"].toDouble(),
    finalDisbursedAmount: json["final_disbursed_amount"] == null ? null : json["final_disbursed_amount"],
    status: json["status"] == null ? null : json["status"],
  );
}
