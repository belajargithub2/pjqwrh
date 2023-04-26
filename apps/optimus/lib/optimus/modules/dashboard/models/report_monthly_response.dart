import 'dart:convert';

ReportMonthlyResponse reportMonthlyResponseFromJson(String str) =>
    ReportMonthlyResponse.fromJson(json.decode(str));

class ReportMonthlyResponse {
  ReportMonthlyResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ReportMonthlyResponse.fromJson(Map<String, dynamic> json) =>
      ReportMonthlyResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.performancePercentageMonth,
    this.dashboardPerMonth,
  });

  String? performancePercentageMonth;
  List<DashboardPerMonth>? dashboardPerMonth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        performancePercentageMonth: json["performance_percentage_month"],
        dashboardPerMonth: List<DashboardPerMonth>.from(
            json["dashboard_per_months"]
                .map((x) => DashboardPerMonth.fromJson(x))),
      );
}

class DashboardPerMonth {
  DashboardPerMonth({
    this.monthQty,
    this.monthValue,
    this.payToDealerAmount,
    this.status,
  });

  int? monthQty;
  double? monthValue;
  double? payToDealerAmount;
  String? status;

  factory DashboardPerMonth.fromJson(Map<String, dynamic> json) =>
      DashboardPerMonth(
        monthQty: json["month_qty"],
        monthValue: json["month_value"].toDouble(),
        payToDealerAmount: json["pay_to_dealer_amount"].toDouble(),
        status: json["status"],
      );
}
