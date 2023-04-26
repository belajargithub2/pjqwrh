import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_yearly_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/empty_table.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class YearlyPage extends GetView<BumblebeeYearlyPageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BumblebeeYearlyPageController>(
      init: BumblebeeYearlyPageController(),
      builder: (c) => Container(
        width: DeasySizeConfigUtils.screenWidth,
        color: DeasyColor.neutral000,
        padding: EdgeInsets.all(15),
        child: ListView(
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if (c.role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT))
              Text('Transaksi Bulan Ini',
                  style: TextStyle(
                    fontSize: DeasySizeConfigUtils.blockVertical * 2,
                    fontFamily: 'KBFGDisplayBold',
                  )),
            if (c.role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT))
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.03,
              ),
            Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      color: DeasyColor.kpBlue50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Text(
                            "Status",
                            style: TextStyle(
                              color: DeasyColor.kpBlue700,
                              fontFamily: 'KBFGDisplayLight',
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.5,
                            ),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            c.orderApplicationText.value,
                            style: TextStyle(
                              color: DeasyColor.kpBlue700,
                              fontFamily: 'KBFGDisplayLight',
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.5,
                            ),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            c.incomeDisbursementText.value,
                            style: TextStyle(
                              color: DeasyColor.kpBlue700,
                              fontFamily: 'KBFGDisplayLight',
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.5,
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    Obx(() => dataTable(context, c.role.value, c.rowYear))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget dataTable(BuildContext context, String role, List<DataRow> rowYear) {
    if (role.isContainIgnoreCase(ContentConstant.ROLE_AGENT) &&
        rowYear.isEmpty) {
      return EmptyTable(
        onPressSubmission: () {
          controller.homePageController!.navigateToSubmitOrder();
        },
      );
    } else if (rowYear.isNotEmpty) {
      return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: DataTable(
          horizontalMargin: 5,
          columnSpacing: 20,
          dividerThickness: 0.0,
          headingRowHeight: 0.0,
          columns: [
            DataColumn(label: SizedBox()),
            DataColumn(label: SizedBox()),
            DataColumn(label: SizedBox()),
          ],
          rows: rowYear.isNotEmpty
              ? rowYear
              : DataRow(cells: []) as List<DataRow>,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
