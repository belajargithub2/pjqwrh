import 'dart:convert';

DashboardReportResponse dashboardReportResponseFromJson(String str) => DashboardReportResponse.fromJson(json.decode(str));

String dashboardReportResponseToJson(DashboardReportResponse data) => json.encode(data.toJson());

class DashboardReportResponse {
  DashboardReportResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory DashboardReportResponse.fromJson(Map<String, dynamic> json) => DashboardReportResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.dayQty,
    this.dayValue,
    this.monthQty,
    this.monthValue,
    this.yearQty,
    this.yearValue,
  });

  int? dayQty;
  int? dayValue;
  int? monthQty;
  int? monthValue;
  int? yearQty;
  int? yearValue;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dayQty: json["day_qty"] == null ? null : json["day_qty"],
    dayValue: json["day_value"] == null ? null : json["day_value"],
    monthQty: json["month_qty"] == null ? null : json["month_qty"],
    monthValue: json["month_value"] == null ? null : json["month_value"],
    yearQty: json["year_qty"] == null ? null : json["year_qty"],
    yearValue: json["year_value"] == null ? null : json["year_value"],
  );

  Map<String, dynamic> toJson() => {
    "day_qty": dayQty == null ? null : dayQty,
    "day_value": dayValue == null ? null : dayValue,
    "month_qty": monthQty == null ? null : monthQty,
    "month_value": monthValue == null ? null : monthValue,
    "year_qty": yearQty == null ? null : yearQty,
    "year_value": yearValue == null ? null : yearValue,
  };
}
