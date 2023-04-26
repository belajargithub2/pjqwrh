import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/models/report_year_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/repositories/bumblebee_dashboard_report_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeYearlyPageController extends GetxController {
  final BumblebeeHomePageController? homePageController;
  BumblebeeYearlyPageController({this.homePageController});

  final dashboardReportRepository = new BumblebeeDashboardReportRepository();
  final RxList<DataRow> rowYear = <DataRow>[].obs;
  final RxList<DashboardPerYear> listYear = <DashboardPerYear>[].obs;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final orderApplicationText = "".obs;
  final incomeDisbursementText = "".obs;
  final role = "".obs;

  final _pageCon = Get.find<BumblebeeHomePageController>();

  @override
  void onInit() {
    getRole();
    fetchYearReport();
    DeasySizeConfigUtils().init(context: Get.context);
    super.onInit();
  }

  getRole() {
    role.value = _pageCon.role.value;
  }

  fetchYearReport() async {
    rowYear.clear();
    listYear.clear();

    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      orderApplicationText.value = ContentConstant.dashboardTableHeaderTextOrder;
      incomeDisbursementText.value =
          ContentConstant.dashboardTableHeaderTextDisbursement;

      await dashboardReportRepository
          .fetchApiAgentReportYearly(Get.context)
          .then((val) {
        bool _isEmpty = true;
        val.data!.forEach((element) {
          if (element.yearQty != 0) {
            _isEmpty = false;
          }

          if (!element.status!
              .isContainIgnoreCase(ContentConstant.orderStatusIncoming)) {
            listYear.add(DashboardPerYear(
                yearQty: element.yearQty,
                yearValue: element.yearValue,
                status: element.status));
          }
        });

        if (!_isEmpty) {
          _pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 2.27;
          addToRow(listYear);
        } else {
          _pageCon.containerHeight.value = DeasySizeConfigUtils.screenHeight! / 4.5;
        }

        var approved = val.data!.singleWhere((element) =>
            element.status!.isContainIgnoreCase(ContentConstant.orderStatusApproved));
        _pageCon.totalOrder.value = approved.yearValue!;
        _pageCon.countTransaction.value = approved.yearQty!;
      });
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      orderApplicationText.value =
          ContentConstant.dashboardTableHeaderTextApplication;
      incomeDisbursementText.value = ContentConstant.dashboardTableHeaderTextIncome;

      await dashboardReportRepository
          .fetchApiReportYear(Get.context)
          .then((val) {
        listYear.value = val.data!.dashboardPerYears!;

        addToRow(listYear);

        var purchaseConfirmed = val.data!.dashboardPerYears!.singleWhere(
            (element) => element.status!
                .isContainIgnoreCase(ContentConstant.orderStatusPurchaseConfirmed));
        _pageCon.stringIncomeInfo.value = ContentConstant.dashboardYearlyIncome;
        _pageCon.stringAplikanInfo.value = ContentConstant.dashboardYearlyAplicant;
        _pageCon.totalOrder.value = purchaseConfirmed.yearValue!;
        _pageCon.countTransaction.value = purchaseConfirmed.yearQty!;
      });
    }
  }

  addToRow(List<DashboardPerYear> data) {
    data.forEach((element) {
      rowYear.add(DataRow(cells: [
        DataCell(_pageCon.setStatus(element.status ?? "")),
        DataCell(Text(
          '${element.yearQty}',
          style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
        )),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${element.yearValue.toString().toRupiah()}',
            style: TextStyle(fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
          ),
        )),
      ]));
      update();
    });
  }
}
