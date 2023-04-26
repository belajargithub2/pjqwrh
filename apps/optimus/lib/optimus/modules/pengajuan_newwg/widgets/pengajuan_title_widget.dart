import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

Padding titleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: DeasyTextView(
        text: "Pengajuan Konsumen",
        fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
        fontFamily: FontFamily.bold,
      ),
    );
  }