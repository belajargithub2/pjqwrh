import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_transaction_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class DashboardApplicantCardItem
    extends GetView<DashboardTransactionController> {
  final String? status;
  final String qty;
  final double value;
  final double itemHeight;
  final double itemWidth;

  DashboardApplicantCardItem(
      {required this.status,
      required this.qty,
      required this.value,
      required this.itemHeight,
      required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  controller.getGridImagePath(status!.toLowerCase()),
                  height: itemWidth / 10 * 2,
                  width: itemWidth / 10 * 2,
                ),
                SizedBox(width: itemWidth / 10),
                Text(controller.getString(status!.toLowerCase()),
                    style: TextStyle(
                        color:
                            controller.getGridItemColor(status!.toLowerCase()),
                        fontSize: itemWidth / 10 - 5,
                        height: 1.4,
                        fontFamily: "KBFGDisplayMedium")),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeasyTextView(
                      text: qty,
                      fontFamily: FontFamily.bold,
                      maxLines: 3,
                      fontColor: DeasyColor.neutral900,
                      fontSize: itemWidth / 10 - 7,
                    ),
                    Expanded(
                      child: DeasyTextView(
                        text: value.toString().toRupiah(),
                        textAlign: TextAlign.end,
                        maxLines: 3,
                        fontFamily: FontFamily.bold,
                        fontColor: DeasyColor.neutral900,
                        fontSize: itemWidth / 10 - 7,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeasyTextView(
                      text: ContentConstant.application,
                      fontColor: Colors.grey,
                      fontSize: itemWidth / 10 - 7,
                    ),
                    DeasyTextView(
                      text: ContentConstant.rupiah,
                      fontColor: Colors.grey,
                      fontSize: itemWidth / 10 - 7,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
