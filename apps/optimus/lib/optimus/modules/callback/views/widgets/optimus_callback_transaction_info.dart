import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/controllers/optimus_callback_detail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/models/callback_detail_response.dart';
import 'package:deasy_color/deasy_color.dart';

class OptimusCallbackTransactionInfo
    extends GetView<OptimusCallbackDetailController> {
  final CallbackDetailData? callbackDetailData;
  final requestPayloadJson;
  final responsePayloadJson;
  final index;

  OptimusCallbackTransactionInfo(
      {this.callbackDetailData,
      this.requestPayloadJson,
      this.responsePayloadJson,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 28.0),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: DeasyTextView(
                  text: "Transaction Information",
                  fontSize: 16,
                  fontFamily: FontFamily.bold),
            ),
            IconButton(
                icon: controller.expandedIndexList.contains(index)
                    ? Icon(Icons.keyboard_arrow_down_outlined,
                        color: DeasyColor.neutral500, size: 40.0)
                    : Icon(Icons.keyboard_arrow_right_outlined,
                        color: DeasyColor.neutral500, size: 40.0),
                onPressed: () {
                  controller.onTapExpand(index);
                }),
          ]),
          SizedBox(height: 12.0),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: DeasyColor.kpBlue200, width: 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: DeasyColor.kpBlue200,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 11.0))
                ],
              ),
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: DeasyTextView(
                                text: "Status",
                                fontColor: DeasyColor.neutral400,
                                fontSize: 16.0)),
                        Container(
                            width: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            decoration: callbackDetailData!.status == 200
                                ? BoxDecoration(
                                    color: DeasyColor.kpBlue50,
                                    borderRadius: BorderRadius.circular(10.0))
                                : BoxDecoration(
                                    color: DeasyColor.dmsFFD2CF,
                                    borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                                child: callbackDetailData!.status == 200
                                    ? DeasyTextView(
                                        text: callbackDetailData!.status
                                            .toString(),
                                        fontColor: DeasyColor.semanticInfo300,
                                        fontSize: 12.0)
                                    : DeasyTextView(
                                        text: callbackDetailData!.status
                                            .toString(),
                                        fontColor: DeasyColor.dmsF46363,
                                        fontSize: 12.0)))
                      ]),
                      SizedBox(height: 10.0),
                      Divider(color: DeasyColor.kpBlue200),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                              child: DeasyTextView(
                                  text: "Date",
                                  fontColor: DeasyColor.neutral400,
                                  fontSize: 16.0)),
                          Text(
                              callbackDetailData!.createdAt!.toFormattedDate(
                                  format: "dd MMM yyyy, HH:mm:ss"),
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Divider(color: DeasyColor.kpBlue200),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                              child: DeasyTextView(
                                  text: "Prospect ID",
                                  fontColor: DeasyColor.neutral400,
                                  fontSize: 16.0)),
                          Text(callbackDetailData!.prospectId!,
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Divider(color: DeasyColor.kpBlue200),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                              child: DeasyTextView(
                                  text: "Callback Type",
                                  fontColor: DeasyColor.neutral400,
                                  fontSize: 16.0)),
                          Text(callbackDetailData!.tipe!,
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ],
                  ))),
          SizedBox(height: 30.0),
          controller.expandedIndexList.contains(index)
              ? DeasyTextView(
                  text: "Request Payload",
                  fontSize: 16,
                  fontFamily: FontFamily.bold)
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? SizedBox(height: 12.0)
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: DeasyColor.kpBlue200, width: 1),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DeasyColor.kpBlue200,
                          blurRadius: 17.0,
                          offset: Offset(0.0, 18.0))
                    ],
                  ),
                  child: DeasyTextView(text: requestPayloadJson, maxLines: 10))
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? SizedBox(height: 30.0)
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? DeasyTextView(
                  text: "Event History",
                  fontSize: 16,
                  fontFamily: FontFamily.bold)
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? SizedBox(height: 12.0)
              : SizedBox(),
          controller.expandedIndexList.contains(index)
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: DeasyColor.kpBlue200, width: 1),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DeasyColor.kpBlue200,
                          blurRadius: 17.0,
                          offset: Offset(0.0, 18.0))
                    ],
                  ),
                  child: DeasyTextView(text: responsePayloadJson, maxLines: 10))
              : SizedBox(),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
