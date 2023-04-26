import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_tenor_model.dart';

Widget optimusRingkasanSkemaPembayaranWidget(TenorModel tenorModel) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      DeasyTextView(
          text: "Ringkasan Skema Pembayaran",
          fontColor: DeasyColor.neutral900,
          fontSize: DeasySizeConfigUtils.blockVertical * 2,
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
                fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                text: "Periode Cicilan",
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.light),
          ),
          Expanded(
            flex: 3,
            child: DeasyTextView(
                fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                text: "${tenorModel.tenor} Bulan",
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
                fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                text: "Angsuran/Bulan",
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.light),
          ),
          Expanded(
            flex: 3,
            child: DeasyTextView(
                fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                text:
                    "Rp. ${tenorModel.installmentAmount.toString().toDecimalFormat()}",
                maxLines: 4,
                fontFamily: FontFamily.light),
          )
        ],
      ),
    ],
  );
}
