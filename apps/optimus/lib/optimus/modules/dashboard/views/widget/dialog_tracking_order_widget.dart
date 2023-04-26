import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class DialogTrackingOrderWidget extends GetView {
  final String? orderId;
  final String? status;
  final String? noAWB;
  final String? logisticName;
  final String deliveryTime;
  final String arrivedTime;
  final String? receiverName;
  final String? mobilePhone;
  final String? shippingAddress;

  DialogTrackingOrderWidget(
      {required this.orderId,
      required this.status,
      required this.noAWB,
      required this.logisticName,
      required this.deliveryTime,
      required this.arrivedTime,
      required this.receiverName,
      required this.mobilePhone,
      required this.shippingAddress});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: DeasySizeConfigUtils.screenWidth! / 3.5,
            vertical: DeasySizeConfigUtils.screenHeight! / 4.2),
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
                    DialogConstant.trackingDetailDialogTitle,
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.orderId,
                              style: TextStyle(height: 1)),
                          Expanded(
                              child: Text(' : $orderId',
                                  style: TextStyle(height: 1)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.status,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $status',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.noAwb,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $noAWB',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.logisticName,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $logisticName',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.deliveryTime,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $deliveryTime',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.arrivedTime,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $arrivedTime',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.receiverName,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $receiverName',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.shippingAddress,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $shippingAddress',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ContentConstant.receiverMobilePhone,
                              style: TextStyle(height: 2)),
                          Expanded(
                              child: Text(' : $mobilePhone',
                                  style: TextStyle(height: 2)))
                        ],
                      ),
                    ]))
          ],
        ));
  }
}
