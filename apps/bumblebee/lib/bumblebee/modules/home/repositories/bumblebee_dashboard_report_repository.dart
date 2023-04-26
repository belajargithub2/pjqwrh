import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/agent_report_daily_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_daily_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/agent_report_monthly_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/agent_report_yearly_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_monthly_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_year_response.dart';

import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class BumblebeeDashboardReportRepository {
  DioClient _provider = DioClient();

  Future<ReportDailyResponse> fetchApiReportDaily(BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/days_mobile", null);
    return ReportDailyResponse.fromJson(response);
  }

  Future<ReportMonthlyResponse> fetchApiReportMonthly(
      BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/months_mobile", null);
    return ReportMonthlyResponse.fromJson(response);
  }

  Future<ReportYearsResponse> fetchApiReportYear(BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/years_mobile", null);
    return ReportYearsResponse.fromJson(response);
  }

  Future<AgentReportDailyResponse> fetchApiAgentReportDaily(
      BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/agents/days", null);
    return AgentReportDailyResponse.fromJson(response);
  }

  Future<AgentReportMonthlyResponse> fetchApiAgentReportMonthly(
      BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/agents/months", null);
    return AgentReportMonthlyResponse.fromJson(response);
  }

  Future<AgentReportYearlyResponse> fetchApiAgentReportYearly(
      BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "dashboards/mv/agents/years", null);
    return AgentReportYearlyResponse.fromJson(response);
  }
}
