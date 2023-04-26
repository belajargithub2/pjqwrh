import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/merchant_controller.dart';

class DashboardMerchant extends GetView<MerchantController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Merchant",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Urutan merchant terbaikmu",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            Obx(() => Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: controller.listRankingMerchant.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            controller
                                                .listRankingMerchant[index]
                                                .name!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            maxLines: 1)),
                                    index < 2
                                        ? Icon(Icons.arrow_upward,
                                            color: HexColor("#2ED477"))
                                        : Icon(Icons.arrow_downward,
                                            color: HexColor("#F46363")),
                                    index < 2
                                        ? Text(
                                            controller
                                                    .listRankingMerchant[index]
                                                    .percentage
                                                    .toString() +
                                                "%",
                                            style: TextStyle(
                                                color: HexColor("#2ED477"),
                                                fontSize: 14))
                                        : Text(
                                            controller
                                                    .listRankingMerchant[index]
                                                    .percentage
                                                    .toString() +
                                                "%",
                                            style: TextStyle(
                                                color: HexColor("#F46363"),
                                                fontSize: 14))
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                    color: HexColor("#E3E3E3"),
                                    thickness: 1.8,
                                  ),
                              itemCount: 4)),
                ))
          ],
        ));
  }
}
