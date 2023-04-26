import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:kreditplus_deasy_website/core/model/agent_orders_response.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusFilterStatusDropdownWidget
    extends GetWidget<OptimusSubsidiDealerTableController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isOpenStatusFilter.isTrue,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pilih Status',
                    style: TextStyle(color: DeasyColor.semanticInfo300)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.statusMap.keys.map((String key) {
                      return Row(
                        children: [
                          Checkbox(
                              activeColor: DeasyColor.kpYellow500,
                              value: controller.statusMap[key],
                              onChanged: (bool? value) {
                                controller.statusMap[key] = value;
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(formatStringStatus(key)),
                          ),
                        ],
                      );
                    }).toList()),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: DeasyColor.kpYellow500,
                            side: BorderSide(
                                width: 1, color: DeasyColor.neutral000),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            controller.onApplyStatusFilter();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Apply",
                              style: TextStyle(color: DeasyColor.neutral000),
                            ),
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: DeasyColor.neutral000,
                          side: BorderSide(
                              width: 1, color: DeasyColor.kpYellow500),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          controller.clearStatusFilter();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Clear",
                            style: TextStyle(color: DeasyColor.kpYellow500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatStringStatus(String status) {
    switch (status) {
      case ContentConstant.STATUS_APPROVED:
        return EnumOrderTransaction.approved.name;
      case ContentConstant.STATUS_PURCHASE_CONFIRMED:
        return EnumOrderTransaction.purchaseConfirmed.name;
      case ContentConstant.STATUS_CANCELED:
        return EnumOrderTransaction.canceled.name;
      case ContentConstant.STATUS_REJECT:
        return EnumOrderTransaction.rejected.name;
      case ContentConstant.STATUS_CANCEL_REQUEST:
        return EnumOrderTransaction.cancelRequest.name;
      case ContentConstant.STATUS_ON_PROGRESS:
        return EnumOrderTransaction.onProgress.name;
      case ContentConstant.STATUS_PAID:
        return EnumOrderTransaction.disbursed.name;
      default:
        return "";
    }
  }
}
