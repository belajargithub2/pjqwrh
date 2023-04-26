import 'dart:convert';

ReportDailyResponse reportDailyResponseFromJson(String str) =>
    ReportDailyResponse.fromJson(json.decode(str));

String reportDailyResponseToJson(ReportDailyResponse data) =>
    json.encode(data.toJson());

class ReportDailyResponse {
  ReportDailyResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ReportDailyResponse.fromJson(Map<String, dynamic> json) =>
      ReportDailyResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.performancePercentageDays,
    this.dashboardPerDays,
  });

  String? performancePercentageDays;
  List<DashboardPerDay>? dashboardPerDays;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        performancePercentageDays: json["performance_percentage_days"],
        dashboardPerDays: List<DashboardPerDay>.from(
            json["dashboard_per_days"].map((x) => DashboardPerDay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "performance_percentage_days": performancePercentageDays,
        "dashboard_per_days":
            List<dynamic>.from(dashboardPerDays!.map((x) => x.toJson())),
      };
}

class DashboardPerDay {
  DashboardPerDay({
    this.dayQty,
    this.dayValue,
    this.payToDealerAmount,
    this.status,
  });

  int? dayQty;
  double? dayValue;
  double? payToDealerAmount;
  String? status;

  factory DashboardPerDay.fromJson(Map<String, dynamic> json) =>
      DashboardPerDay(
        dayQty: json["day_qty"],
        dayValue: json["day_value"].toDouble(),
        payToDealerAmount: json["pay_to_dealer_amount"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "day_qty": dayQty,
        "day_value": dayValue,
        "pay_to_dealer_amount": payToDealerAmount,
        "status": status,
      };
}
