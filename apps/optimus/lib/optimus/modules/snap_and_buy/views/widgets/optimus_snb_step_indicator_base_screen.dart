import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/step_indicator/optimus_step_indicator_mobile_screen.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/step_indicator/optimus_step_indicator_tab_screen.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/step_indicator/optimus_step_indicator_web_screen.dart';

class OptimusStepIndicatorScreen extends StatelessWidget {
  final int index;

  OptimusStepIndicatorScreen({this.index = 0});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return OptimusWebStepIndicatorScreen(
              index: index,
              nameSectionOne: ContentConstant.nameSectionOneSnbWeb,
              nameSectionTwo: ContentConstant.nameSectionTwoSnbWeb,
              nameSectionThree: ContentConstant.nameSectionThreeSnbWeb);
        }

        if (screenType == DeasyScreenType.tablet) {
          return OptimusTabStepIndicatorScreen(
              index: index,
              nameSectionOne: ContentConstant.nameSectionOneSnbTab,
              nameSectionTwo: ContentConstant.nameSectionTwoSnbTab,
              nameSectionThree: ContentConstant.nameSectionThreeSnbTab);
        }

        return OptimusMobileStepIndicatorScreen(
            index: index,
            nameSectionOne: ContentConstant.nameSectionOneSnbMobile,
            nameSectionTwo: ContentConstant.nameSectionTwoSnbMobile,
            nameSectionThree: ContentConstant.nameSectionThreeSnbMobile);
      },
    );
  }
}
