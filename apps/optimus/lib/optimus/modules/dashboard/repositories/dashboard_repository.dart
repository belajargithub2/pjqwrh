import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/report_daily_response.dart';
import 'package:kreditplus_deasy_website/core/model/orders/tracking_order_response_model.dart';
import 'package:kreditplus_deasy_website/core/model/statistic_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/dashboard_search_merchant_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/report_monthly_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/report_year_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class DashboardRepository {
  DioClient _provider = DioClient();
  String isNonMerchant = 'non_merchant';

  Future<ReportDailyResponse> fetchTransactionsByDay(
      BuildContext? context, String status,
      {String? supplierId}) async {
    final response = await _provider.get(
        context,
        Scope.MERCHANT,
        supplierId != isNonMerchant
            ? "dashboards/mv/days?supplier_id=$supplierId"
            : "dashboards/mv/days",
        null);
    return ReportDailyResponse.fromJson(response);
  }

  Future<ReportYearsResponse> fetchTransactionsByYear(
      BuildContext? context, String status,
      {String? supplierId}) async {
    final response = await _provider.get(
        context,
        Scope.MERCHANT,
        supplierId != isNonMerchant
            ? "dashboards/mv/years?supplier_id=$supplierId"
            : "dashboards/mv/years",
        null);
    return ReportYearsResponse.fromJson(response);
  }

  Future<ReportMonthlyResponse> fetchTransactionsByMonth(
      BuildContext? context, String status,
      {String? supplierId}) async {
    final response = await _provider.get(
        context,
        Scope.MERCHANT,
        supplierId != isNonMerchant
            ? "dashboards/mv/months?supplier_id=$supplierId"
            : "dashboards/mv/months",
        null);
    return ReportMonthlyResponse.fromJson(response);
  }

  Future<DashboardSearchMerchantResponse> fetchApiDashboardSearchMerchants(
      BuildContext? context,
      {String? searchKey,
      int? page,
      int? limit}) async {
    final response = await _provider.get(context, Scope.MERCHANT,
        "dashboards/merchants?q=$searchKey&page=$page&limit=$limit", null);
    return DashboardSearchMerchantResponse.fromJson(response);
  }

  Future<StatisticResponse> fetchApiDashboardStatistic(
      BuildContext? context, int month) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/weekly?month=$month", null);
    return StatisticResponse.fromJson(response);
  }

  Future<TrackingOrderResponseModel> fetchApiDashboardOrderStatus(
      BuildContext? context, String? prospectID) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "orders/tracking/$prospectID", null);
    return TrackingOrderResponseModel.fromJson(response);
  }
}
