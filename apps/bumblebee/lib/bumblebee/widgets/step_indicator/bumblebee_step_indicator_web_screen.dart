import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_circle_indicator_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_line_widget.dart';
import 'package:deasy_color/deasy_color.dart';

class BumblebeeWebStepIndicatorScreen extends StatelessWidget {
  final int index;
  final String? nameSectionOne, nameSectionTwo, nameSectionThree;
  BumblebeeWebStepIndicatorScreen(
      {this.index = 0,
      this.nameSectionOne,
      this.nameSectionTwo,
      this.nameSectionThree});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      color: DeasyColor.neutral50,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 18,
                left: DeasySizeConfigUtils.screenWidth! / 15,
                right: DeasySizeConfigUtils.screenWidth! / 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bumblebeeCircleIndicator(index >= 0),
                bumblebeeLine(index > 0),
                bumblebeeCircleIndicator(index > 0),
                bumblebeeLine(index > 1),
                bumblebeeCircleIndicator(index > 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("$nameSectionOne",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: index >= 0
                              ? DeasyColor.neutral900
                              : DeasyColor.neutral400,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("$nameSectionTwo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            color: index > 0
                                ? DeasyColor.neutral900
                                : DeasyColor.neutral400)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("$nameSectionThree",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            color: index > 1
                                ? DeasyColor.neutral900
                                : DeasyColor.neutral400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
