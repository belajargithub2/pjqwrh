import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class DialogPaymentDetailWidget extends GetView {
  final String? orderId;
  final String? agreementNo;
  final String payToDealerDate;
  final String payToDealerAmount;
  final String trackingStatus;

  DialogPaymentDetailWidget(
      {required this.orderId,
      required this.agreementNo,
      required this.payToDealerDate,
      required this.payToDealerAmount,
      required this.trackingStatus});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: DeasySizeConfigUtils.screenWidth! / 3,
            vertical: DeasySizeConfigUtils.screenHeight! / 3.4),
        backgroundColor: DeasyColor.neutral000,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeasySizeConfigUtils.blockHorizontal! * 1.2,
                  vertical: DeasySizeConfigUtils.blockHorizontal! * 1.3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DialogConstant.paymentDetailDialogTitle,
                    style: TextStyle(
                        fontSize: DeasySizeConfigUtils.blockHorizontal! * 1.1,
                        color: DeasyColor.neutral900),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.close,
                      color: DeasyColor.neutral400,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding:
                  EdgeInsets.all(DeasySizeConfigUtils.blockHorizontal! * 1.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(ContentConstant.orderId,
                          style: TextStyle(height: 1)),
                      Text(ContentConstant.agreementNo,
                          style: TextStyle(height: 4)),
                      Text(ContentConstant.paymentDate,
                          style: TextStyle(height: 3)),
                      Text(ContentConstant.nominal,
                          style: TextStyle(height: 3)),
                      Text(ContentConstant.trackingStatus,
                          style: TextStyle(height: 3)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(' : $orderId', style: TextStyle(height: 1)),
                      Text(' : $agreementNo', style: TextStyle(height: 4)),
                      Text(' : $payToDealerDate', style: TextStyle(height: 3)),
                      Text(' : $payToDealerAmount',
                          style: TextStyle(height: 3)),
                      Text(' : $trackingStatus', style: TextStyle(height: 3)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
