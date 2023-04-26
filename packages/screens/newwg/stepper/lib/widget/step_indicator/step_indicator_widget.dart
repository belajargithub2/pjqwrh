import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:stepper/widget/step_indicator/mobile_step_indicator_widget.dart';
import 'package:stepper/widget/step_indicator/tab_step_indicator_widget.dart';
import 'package:stepper/widget/step_indicator/web_step_indicator_widget.dart';

class StepIndicatorWidget extends StatelessWidget {
  final int index;
  final Color activeColor;

  StepIndicatorWidget({this.index = 0, required this.activeColor});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return WebStepIndicatorWidget(
              index: index,
              nameSectionOne: "Verifikasi Data Konsumen",
              nameSectionTwo: "Dokumen Tambahan",
              nameSectionThree: "Pesanan",
              activeColor: activeColor,);
        }

        if (screenType == DeasyScreenType.tablet) {
          return TabStepIndicatorWidget(
              index: index,
              nameSectionOne: "Verifikasi\nData Konsumen",
              nameSectionTwo: "Dokumen\nTambahan",
              nameSectionThree: "Pesanan",
              activeColor: activeColor,);
        }

        return MobileStepIndicatorWidget(
            index: index,
            nameSectionOne: "Verifikasi\nData Konsumen",
            nameSectionTwo: "Dokumen\nTambahan",
            nameSectionThree: "Pesanan",
            activeColor: activeColor,);
      },
    );
  }
}
