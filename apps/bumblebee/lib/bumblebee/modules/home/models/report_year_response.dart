import 'dart:convert';

ReportYearsResponse reportYearsResponseFromJson(String str) =>
    ReportYearsResponse.fromJson(json.decode(str));

class ReportYearsResponse {
  ReportYearsResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ReportYearsResponse.fromJson(Map<String, dynamic> json) =>
      ReportYearsResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.performancePercentageYears,
    this.dashboardPerYears,
  });

  String? performancePercentageYears;
  List<DashboardPerYear>? dashboardPerYears;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        performancePercentageYears: json["performance_percentage_years"],
        dashboardPerYears: List<DashboardPerYear>.from(
            json["dashboard_per_years"]
                .map((x) => DashboardPerYear.fromJson(x))),
      );
}

class DashboardPerYear {
  DashboardPerYear({
    this.yearQty,
    this.yearValue,
    this.payToDealerAmount,
    this.status,
  });

  int? yearQty;
  double? yearValue;
  double? payToDealerAmount;
  String? status;

  factory DashboardPerYear.fromJson(Map<String, dynamic> json) =>
      DashboardPerYear(
        yearQty: json["year_qty"],
        yearValue: json["year_value"].toDouble(),
        payToDealerAmount: json["pay_to_dealer_amount"].toDouble(),
        status: json["status"],
      );
}
