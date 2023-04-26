import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/model/base_response.dart';
import 'package:kreditplus_deasy_website/core/model/dashboard_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/report_incoming_web_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/report_year_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:deasy_color/deasy_color.dart';

import '../models/report_daily_response.dart';
import '../models/report_monthly_response.dart';

class DashboardTransactionController extends GetxController
    with StateMixin<List<DashboardResponse>> {
  DashboardRepository _dashboardRepository;

  final context = Get.context;

  Rxn<ReportIncomingWebResponse> incomingData =
      Rxn<ReportIncomingWebResponse>();
  Rxn<BaseResponse> result = Rxn<BaseResponse>();

  double? incomingValue;
  int? incomingQty;

  DashboardTransactionController(
      {required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository;

  @override
  void onInit() {
    _dashboardRepository = DashboardRepository();
    super.onInit();
  }

  Future fetchApiDashboardsYears({String? supplierId}) async {
    try {
      ReportYearsResponse transactions = await _dashboardRepository
          .fetchTransactionsByYear(context, ContentConstant.STATUS_ON_PROGRESS,
              supplierId: supplierId);
      DashboardPerYear incomingValuePerYear =
          transactions.data!.dashboardPerYears!.singleWhere(
              (element) => element.status!.toLowerCase() == 'incoming');
      incomingValue = incomingValuePerYear.yearValue;
      incomingQty = incomingValuePerYear.yearQty;

      List<DashboardResponse> _transactionsByDay =
          List.generate(transactions.data!.dashboardPerYears!.length, (index) {
        return DashboardResponse(
            status: transactions.data!.dashboardPerYears![index].status,
            value: transactions.data!.dashboardPerYears![index].yearValue,
            payToDealerAmount: transactions
                .data!.dashboardPerYears![index].payToDealerAmount!
                .toDouble(),
            qty: transactions.data!.dashboardPerYears![index].yearQty);
      });

      _transactionsByDay.removeWhere((e) =>
          e.status!.isContainIgnoreCase('Incoming') ||
          e.status!.isContainIgnoreCase('Cancel Request'));

      change(_transactionsByDay, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('$e'));
    }
  }

  Future fetchApiDashboardsDays({String? supplierId}) async {
    change(null, status: RxStatus.loading());
    try {
      ReportDailyResponse transactions = await _dashboardRepository
          .fetchTransactionsByDay(context, ContentConstant.STATUS_ON_PROGRESS,
              supplierId: supplierId);

      DashboardPerDay incomingValuePerDay = transactions.data!.dashboardPerDays!
          .singleWhere(
              (element) => element.status!.toLowerCase() == 'incoming');
      incomingValue = incomingValuePerDay.dayValue;
      incomingQty = incomingValuePerDay.dayQty;

      List<DashboardResponse> _transactionsByDay =
          List.generate(transactions.data!.dashboardPerDays!.length, (index) {
        return DashboardResponse(
            status: transactions.data!.dashboardPerDays![index].status,
            value: transactions.data!.dashboardPerDays![index].dayValue,
            payToDealerAmount: transactions
                .data!.dashboardPerDays![index].payToDealerAmount!
                .toDouble(),
            qty: transactions.data!.dashboardPerDays![index].dayQty);
      });

      _transactionsByDay.removeWhere((e) =>
          e.status!.isContainIgnoreCase('Incoming') ||
          e.status!.isContainIgnoreCase('Cancel Request'));

      change(_transactionsByDay, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('$e'));
    }
  }

  Future<List<DashboardResponse>?> fetchApiDashboardsMonths(
      {String? supplierId}) async {
    try {
      ReportMonthlyResponse transactions = await _dashboardRepository
          .fetchTransactionsByMonth(context, ContentConstant.STATUS_ON_PROGRESS,
              supplierId: supplierId);
      DashboardPerMonth incomingValuePerMonth =
          transactions.data!.dashboardPerMonth!.singleWhere(
              (element) => element.status!.toLowerCase() == 'incoming');
      incomingValue = incomingValuePerMonth.monthValue;
      incomingQty = incomingValuePerMonth.monthQty;

      List<DashboardResponse> _transactionsByDay =
          List.generate(transactions.data!.dashboardPerMonth!.length, (index) {
        return DashboardResponse(
            status: transactions.data!.dashboardPerMonth![index].status,
            value: transactions.data!.dashboardPerMonth![index].monthValue,
            payToDealerAmount: transactions
                .data!.dashboardPerMonth![index].payToDealerAmount!
                .toDouble(),
            qty: transactions.data!.dashboardPerMonth![index].monthQty);
      });

      _transactionsByDay.removeWhere((e) =>
          e.status!.isContainIgnoreCase('Incoming') ||
          e.status!.isContainIgnoreCase('Cancel Request'));

      change(_transactionsByDay, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('$e'));
    }
  }

  String getGridImagePath(String transactionType) {
    switch (transactionType) {
      case 'purchase confirmed':
        {
          return 'resources/images/icons/ic_confirmed_transaction_flag.svg';
        }

      case 'disbursed':
        {
          return 'resources/images/icons/ic_paid.svg';
        }

      case 'on progress':
        {
          return 'resources/images/icons/ic_processed_transaction_flag.svg';
        }

      case 'approved':
        {
          return 'resources/images/icons/ic_approved_transaction_flag.svg';
        }

      case 'canceled':
        {
          return 'resources/images/icons/ic_canceled.svg';
        }

      case 'rejected':
        {
          return 'resources/images/icons/ic_rejected_transaction_flag.svg';
        }

      default:
        {
          return 'resources/images/icons/ic_rejected_transaction_flag.svg';
        }
    }
  }

  String getString(String transactionType) {
    switch (transactionType) {
      case 'purchase confirmed':
        {
          return 'Pembayaran\nDikonfirmasi';
        }

      case 'disbursed':
        {
          return 'Terbayar';
        }

      case 'on progress':
        {
          return 'Dalam Proses';
        }

      case 'approved':
        {
          return 'Disetujui';
        }

      case 'canceled':
        {
          return 'Batal';
        }

      case 'rejected':
        {
          return 'Ditolak';
        }

      default:
        {
          return '-';
        }
    }
  }

  Color getGridItemColor(String transactionType) {
    switch (transactionType) {
      case 'purchase confirmed':
        {
          return DeasyColor.transactionConfirmedColor;
        }

      case 'disbursed':
        {
          return DeasyColor.transactionPaidColor;
        }

      case 'on progress':
        {
          return DeasyColor.transactionProcessedColor;
        }

      case 'approved':
        {
          return DeasyColor.transactionApprovedColor;
        }

      case 'canceled':
        {
          return DeasyColor.neutral400;
        }

      case 'rejected':
        {
          return DeasyColor.transactionRejectedColor;
        }

      default:
        {
          return DeasyColor.transactionRejectedColor;
        }
    }
  }
}
