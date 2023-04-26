import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_asset_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_tenor_model.dart';

Widget optimusRingkasanBelanjaWidget(
    AssetData data,
    OptimusSubmissionSectionController submissionSectionController,
    TenorModel tenorModel,
    OptimusSnapAndBuyBaseController snapAndBuyWebController,
    int dp) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      DeasyTextView(
          text: ContentConstant.shoppingSummary,
          fontColor: DeasyColor.neutral900,
          fontSize: 16.sp,
          fontFamily: FontFamily.bold),
      SizedBox(height: 8),
      Divider(
        color: DeasyColor.neutral400,
      ),
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text: ContentConstant.nameOfGoods,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.light),
          ),
          Expanded(
            flex: 3,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text: "${data.assetName}",
                maxLines: 4,
                fontFamily: FontFamily.light),
          )
        ],
      ),
      SizedBox(height: 18),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text: ContentConstant.price,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.light),
          ),
          Expanded(
            flex: 3,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text:
                    "${submissionSectionController.realPrice.toString().toCurrency()}",
                maxLines: 2,
                fontFamily: FontFamily.light),
          )
        ],
      ),
      Visibility(
        visible: snapAndBuyWebController.isShowDp.value,
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: DeasyTextView(
                    fontSize: 15.5.sp,
                    text: ContentConstant.dpLabelMobile,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.light),
              ),
              Expanded(
                flex: 3,
                child: DeasyTextView(
                    fontSize: 15.5.sp,
                    text: "${dp.toString().toCurrency()}",
                    maxLines: 4,
                    fontFamily: FontFamily.light),
              )
            ],
          ),
        ),
      ),
      SizedBox(height: 18),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text: ContentConstant.totalShopping,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.light),
          ),
          Expanded(
            flex: 3,
            child: DeasyTextView(
                fontSize: 15.5.sp,
                text: tenorModel.af.toString().toCurrency(),
                maxLines: 2,
                fontFamily: FontFamily.light),
          )
        ],
      ),
    ],
  );
}

Widget ringkasanBelanjaWebWidget(
    AssetData data,
    OptimusSubmissionSectionController submissionSectionController,
    String prospectId,
    TenorModel tenorModel,
    OptimusSnapAndBuyBaseController snapAndBuyWebController,
    int dp) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      DeasyTextView(
          text: "$prospectId",
          fontSize: 1.9.h,
          fontColor: DeasyColor.neutral900,
          isSelectable: true,
          fontFamily: FontFamily.bold),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Divider(),
      ),
      DeasyTextView(
          text: ContentConstant.shoppingSummary,
          fontColor: DeasyColor.neutral900,
          isSelectable: true,
          fontSize: 1.9.h,
          fontFamily: FontFamily.bold),
      SizedBox(height: 8),
      Divider(
        color: DeasyColor.neutral400,
      ),
      SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  text: ContentConstant.nameOfGoods,
                  isSelectable: true,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.light),
            ),
            Expanded(
              flex: 3,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  text: "${data.assetName}",
                  maxLines: 2,
                  isSelectable: true,
                  fontFamily: FontFamily.light),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  text: ContentConstant.price,
                  isSelectable: true,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.light),
            ),
            Expanded(
              flex: 3,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  text:
                      "${submissionSectionController.realPrice.toString().toCurrency()}",
                  maxLines: 2,
                  isSelectable: true,
                  fontFamily: FontFamily.light),
            )
          ],
        ),
      ),
      Visibility(
        visible: snapAndBuyWebController.isShowDp.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: DeasyTextView(
                    fontSize: 1.76.h,
                    isSelectable: true,
                    text: ContentConstant.dpLabel,
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.light),
              ),
              Expanded(
                flex: 3,
                child: DeasyTextView(
                    fontSize: 1.76.h,
                    text: "${dp.toString().toCurrency()}",
                    maxLines: 2,
                    isSelectable: true,
                    fontFamily: FontFamily.light),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  isSelectable: true,
                  text: ContentConstant.totalShopping,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.light),
            ),
            Expanded(
              flex: 3,
              child: DeasyTextView(
                  fontSize: 1.76.h,
                  isSelectable: true,
                  text: tenorModel.af.toString().toCurrency(),
                  maxLines: 2,
                  fontFamily: FontFamily.light),
            )
          ],
        ),
      ),
    ],
  );
}
