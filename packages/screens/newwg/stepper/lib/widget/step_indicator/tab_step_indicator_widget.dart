import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:stepper/widget/step_indicator/circle_indicator.dart';
import 'package:stepper/widget/step_indicator/line_indicator.dart';
import 'package:stepper/helper/int_extention.dart';


class TabStepIndicatorWidget extends StatelessWidget {
  final int index;
  final String? nameSectionOne, nameSectionTwo, nameSectionThree;
  final Color activeColor;
  TabStepIndicatorWidget(
      {this.index = 0,
      this.nameSectionOne,
      this.nameSectionTwo,
      this.nameSectionThree,
      required this.activeColor});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      color: DeasyColor.neutral000,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 18,
                left: DeasySizeConfigUtils.screenWidth! / 10.2,
                right: DeasySizeConfigUtils.screenWidth! / 10.2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                circleIndicator(index.isActive1(), activeColor),
                lineIndicator(index.isActive2(), activeColor),
                circleIndicator(index.isActive2(), activeColor),
                lineIndicator(index.isActive3(), activeColor),
                circleIndicator(index.isActive3(), activeColor),
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
                          color: index.isActive1()
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
                    child: Text("$nameSectionOne",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            color: index.isActive2()
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
                            color: index.isActive3()
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
