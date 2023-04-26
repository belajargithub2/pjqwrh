import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/submission_screen/bumblebee_snb_tab_submission_screen.dart';

import 'bumblebee_snb_mobile_submission_screen.dart';
import 'bumblebee_snb_web_submission_screen.dart';

class BumblebeeSnbBaseSubmissionScreen extends StatefulWidget {
  const BumblebeeSnbBaseSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<BumblebeeSnbBaseSubmissionScreen> createState() =>
      _BumblebeeSnbBaseSubmissionScreenState();
}

class _BumblebeeSnbBaseSubmissionScreenState
    extends State<BumblebeeSnbBaseSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return BumblebeeSnbWebSubmissionScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return BumblebeeSnbTabSubmissionScreen();
        }

        return BumblebeeSnbMobileSubmissionScreen();
      },
    );
  }
}
