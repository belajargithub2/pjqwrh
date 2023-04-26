import 'dart:convert';

AgentReportYearlyResponse agentReportYearlyResponseFromJson(String str) => AgentReportYearlyResponse.fromJson(json.decode(str));

class AgentReportYearlyResponse {
  AgentReportYearlyResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Data>? data;

  factory AgentReportYearlyResponse.fromJson(Map<String, dynamic> json) => AgentReportYearlyResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );
}

class Data {
  Data({
    this.yearQty,
    this.yearValue,
    this.finalDisbursedAmount,
    this.status,
  });

  int? yearQty;
  double? yearValue;
  int? finalDisbursedAmount;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    yearQty: json["year_qty"] == null ? null : json["year_qty"],
    yearValue: json["year_value"] == null ? null : json["year_value"].toDouble(),
    finalDisbursedAmount: json["final_disbursed_amount"] == null ? null : json["final_disbursed_amount"],
    status: json["status"] == null ? null : json["status"],
  );
}
