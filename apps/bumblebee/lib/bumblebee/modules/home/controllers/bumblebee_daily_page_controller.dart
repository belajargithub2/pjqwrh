import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_daily_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/repositories/bumblebee_dashboard_report_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeDailyPageController extends GetxController {
  final BumblebeeHomePageController? homePageController;

  BumblebeeDailyPageController({this.homePageController});

  final dashboardReportRepository = new BumblebeeDashboardReportRepository();
  final RxList<DataRow> rowDaily = <DataRow>[].obs;
  final RxList<DashboardPerDay> listDaily = <DashboardPerDay>[].obs;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final orderApplicationText = "".obs;
  final incomeDisbursementText = "".obs;
  final role = "".obs;

  final _pageCon = Get.find<BumblebeeHomePageController>();

  @override
  void onInit() {
    getRole();
    fetchDailyReport();
    super.onInit();
  }

  getRole() {
    role.value = _pageCon.role.value;
  }

  fetchDailyReport() async {
    rowDaily.clear();
    listDaily.clear();

    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      orderApplicationText.value = ContentConstant.dashboardTableHeaderTextOrder;
      incomeDisbursementText.value =
          ContentConstant.dashboardTableHeaderTextDisbursement;

      await dashboardReportRepository
          .fetchApiAgentReportDaily(Get.context)
          .then((val) {
        bool _isEmpty = true;
        val.data!.forEach((element) {
          if (element.dayQty != 0) {
            _isEmpty = false;
          }

          if (!element.status!
              .isContainIgnoreCase(ContentConstant.orderStatusIncoming)) {
            listDaily.add(DashboardPerDay(
                dayQty: element.dayQty,
                dayValue: element.dayValue,
                status: element.status));
          }
        });

        if (!_isEmpty) {
          _pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 2.27;
          addToRow(listDaily);
        } else {
          _pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 4.5;
        }

        var approved = val.data!.singleWhere((element) =>
            element.status!.isContainIgnoreCase(ContentConstant.orderStatusApproved));
        _pageCon.totalOrder.value = approved.dayValue!;
        _pageCon.countTransaction.value = approved.dayQty!;
      });
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      orderApplicationText.value =
          ContentConstant.dashboardTableHeaderTextApplication;
      incomeDisbursementText.value = ContentConstant.dashboardTableHeaderTextIncome;

      await dashboardReportRepository
          .fetchApiReportDaily(Get.context)
          .then((val) {
        listDaily.value = val.data!.dashboardPerDays!;

        addToRow(listDaily);

        var purchaseConfirmed = val.data!.dashboardPerDays!.singleWhere(
            (element) => element.status!
                .isContainIgnoreCase(ContentConstant.orderStatusPurchaseConfirmed));
        _pageCon.stringIncomeInfo.value = ContentConstant.dashboardDailyIncome;
        _pageCon.stringAplikanInfo.value = ContentConstant.dashboardDailyAplicant;
        _pageCon.totalOrder.value = purchaseConfirmed.dayValue!;
        _pageCon.countTransaction.value = purchaseConfirmed.dayQty!;
      });
    }
  }

  addToRow(List<DashboardPerDay> data) {
    data.forEach((element) {
      rowDaily.add(DataRow(cells: [
        DataCell(_pageCon.setStatus(element.status ?? "")),
        DataCell(Text(
          '${element.dayQty}',
          style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
        )),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${element.dayValue.toString().toRupiah()}',
            style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
          ),
        )),
      ]));
      update();
    });
  }
}
