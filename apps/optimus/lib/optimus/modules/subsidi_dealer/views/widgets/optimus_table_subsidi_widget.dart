import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusTableSubsidiWidget
    extends GetView<OptimusSubsidiDealerTableController> {
  const OptimusTableSubsidiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.subsidiList.isEmpty
        ? SizedBox(height: 150)
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 20),
            width: double.infinity,
            child: RawScrollbar(
              thickness: 11,
              isAlwaysShown: true,
              thumbColor: DeasyColor.neutral400,
              controller: controller.tableScrollController,
              child: SingleChildScrollView(
                controller: controller.tableScrollController,
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    dataRowHeight: 70,
                    columns: <DataColumn>[
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.orderId,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                      if (flavorConfiguration!.flavorName == "dev")
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.merchantLabel,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.namaProduk,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.status,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.tanggalTransaksi,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.hargaProdukOtr,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.hargaNtf,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.hargaTotalOtr,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                      DataColumn(
                        label: DeasyTextView(
                            text: ContentConstant.subsidiAmount,
                            fontColor: DeasyColor.dms2DB0E2),
                      ),
                    ],
                    rows: controller.subsidiList
                        .map((item) => DataRow(cells: [
                              DataCell(DeasyTextView(
                                text: item.orderId,
                                fontColor: Colors.black,
                              )),
                              //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                              if (flavorConfiguration!.flavorName == "dev")
                              DataCell(
                                  DeasyTextView(text: item.supplierName)),
                              DataCell(
                                  DeasyTextView(text: item.itemDescription)),
                              DataCell(DeasyTextView(text: item.orderStatus)),
                              DataCell(DeasyTextView(
                                  text: item.orderDate!.toString().toFormattedDate(
                                    format: DateConstant.dateFormat2,
                                    convertToLocal: true,
                                    locale: 'id'
                                  ))),
                              DataCell(DeasyTextView(
                                  text: item.otr.toString().toRupiahNoDecimal())),
                              DataCell(DeasyTextView(
                                  text: item.ntfAmount.toString().toRupiahNoDecimal())),
                              DataCell(
                                DeasyTextView(
                                    text: item.totalOtr.toString().toRupiahNoDecimal()),
                              ),
                              DataCell(
                                DeasyTextView(
                                    text: item.subsidiAmount
                                        .toString()
                                        .toRupiah()),
                              )
                            ]))
                        .toList()),
              ),
            ),
        ));
  }
}
