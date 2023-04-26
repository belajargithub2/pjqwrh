import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/step_indicator/bumblebee_step_indicator_mobile_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/step_indicator/bumblebee_step_indicator_tab_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/step_indicator/bumblebee_step_indicator_web_screen.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeStepIndicatorScreen extends StatelessWidget {
  final int index;

  BumblebeeStepIndicatorScreen({this.index = 0});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return BumblebeeWebStepIndicatorScreen(
              index: index,
              nameSectionOne: ContentConstant.nameSectionOneSnbWeb,
              nameSectionTwo: ContentConstant.nameSectionTwoSnbWeb,
              nameSectionThree: ContentConstant.nameSectionThreeSnbWeb);
        }

        if (screenType == DeasyScreenType.tablet) {
          return BumblebeeTabStepIndicatorScreen(
              index: index,
              nameSectionOne: ContentConstant.nameSectionOneSnbTab,
              nameSectionTwo: ContentConstant.nameSectionTwoSnbTab,
              nameSectionThree: ContentConstant.nameSectionThreeSnbTab);
        }

        return BumblebeeMobileStepIndicatorScreen(
            index: index,
            nameSectionOne: ContentConstant.nameSectionOneSnbMobile,
            nameSectionTwo: ContentConstant.nameSectionTwoSnbMobile,
            nameSectionThree: ContentConstant.nameSectionThreeSnbMobile);
      },
    );
  }
}
