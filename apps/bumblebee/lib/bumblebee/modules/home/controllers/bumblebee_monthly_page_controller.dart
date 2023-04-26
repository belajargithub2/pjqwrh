import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_monthly_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/repositories/bumblebee_dashboard_report_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeMonthlyPageController extends GetxController {
  final BumblebeeHomePageController? homePageController;
  BumblebeeMonthlyPageController({this.homePageController});

  final dashboardReportRepository = new BumblebeeDashboardReportRepository();
  final rowMonth = <DataRow>[].obs;
  final listMonth = <DashboardPerMonth>[].obs;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final pageCon = Get.find<BumblebeeHomePageController>();
  final orderApplicationText = "".obs;
  final incomeDisbursementText = "".obs;
  final role = "".obs;

  @override
  void onInit() {
    getRole();
    fetchMonthReport();
    DeasySizeConfigUtils().init(context: Get.context);
    super.onInit();
  }

  getRole() {
    role.value = pageCon.role.value;
  }

  fetchMonthReport() async {
    rowMonth.clear();
    listMonth.clear();

    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      orderApplicationText.value = ContentConstant.dashboardTableHeaderTextOrder;
      incomeDisbursementText.value =
          ContentConstant.dashboardTableHeaderTextDisbursement;

      await dashboardReportRepository
          .fetchApiAgentReportMonthly(Get.context)
          .then((val) {
        bool _isEmpty = true;
        val.data?.forEach((element) {
          if (element.monthQty != 0) {
            _isEmpty = false;
          }

          if (!element.status!
              .isContainIgnoreCase(ContentConstant.orderStatusIncoming)) {
            listMonth.add(DashboardPerMonth(
                monthQty: element.monthQty,
                monthValue: element.monthValue,
                status: element.status));
          }
        });

        if (!_isEmpty) {
          pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 2.27;
          addToRow(listMonth);
        } else {
          pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 4.5;
        }

        var approved = val.data?.singleWhere((element) =>
            element.status!.isContainIgnoreCase(ContentConstant.orderStatusApproved));
        pageCon.totalOrder.value = approved!.monthValue!;
        pageCon.countTransaction.value = approved.monthQty!;
      });
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      orderApplicationText.value =
          ContentConstant.dashboardTableHeaderTextApplication;
      incomeDisbursementText.value = ContentConstant.dashboardTableHeaderTextIncome;

      await dashboardReportRepository
          .fetchApiReportMonthly(Get.context)
          .then((val) {
        listMonth.value = val.data!.dashboardPerMonth!;

        addToRow(listMonth);

        var purchaseConfirmed = val.data?.dashboardPerMonth?.singleWhere(
            (element) => element.status!
                .isContainIgnoreCase(ContentConstant.orderStatusPurchaseConfirmed));
        pageCon.stringIncomeInfo.value = ContentConstant.dashboardMonthlyIncome;
        pageCon.stringAplikanInfo.value = ContentConstant.dashboardMonthlyAplicant;
        pageCon.totalOrder.value = purchaseConfirmed!.monthValue!;
        pageCon.countTransaction.value = purchaseConfirmed.monthQty!;
      });
    }
  }

  addToRow(List<DashboardPerMonth> data) {
    data.forEach((element) {
      rowMonth.add(DataRow(cells: [
        DataCell(pageCon.setStatus(element.status ?? "")),
        DataCell(Text(
          '${element.monthQty}',
          style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
        )),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${element.monthValue.toString().toRupiah()}',
            style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
          ),
        )),
      ]));
      update();
    });
  }
}
