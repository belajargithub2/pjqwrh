import 'package:flutter_svg/flutter_svg.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  final bool isAgent;

  EmptyWidget({this.isAgent = false});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          '${ImageConstant.RESOURCES_IMAGES_PATH}img_pengajuan_empty.svg',
        ),
        SizedBox(height: 16.0),
        Text(
          "Kamu belum memiliki Laporan ${isAgent ? "Order" : "Transaksi"}",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: DeasyColor.neutral900),
        ),
      ],
    ));
  }
}
