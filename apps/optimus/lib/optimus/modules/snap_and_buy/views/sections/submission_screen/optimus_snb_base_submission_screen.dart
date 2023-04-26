import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/submission_screen/optimus_snb_tab_submission_screen.dart';

import 'optimus_snb_mobile_submission_screen.dart';
import 'optimus_snb_web_submission_screen.dart';

class OptimusSnbBaseSubmissionScreen extends StatefulWidget {
  const OptimusSnbBaseSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<OptimusSnbBaseSubmissionScreen> createState() =>
      _OptimusSnbBaseSubmissionScreenState();
}

class _OptimusSnbBaseSubmissionScreenState
    extends State<OptimusSnbBaseSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return OptimusSnbWebSubmissionScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return OptimusSnbTabSubmissionScreen();
        }

        return OptimusSnbMobileSubmissionScreen();
      },
    );
  }
}
