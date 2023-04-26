import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';

import 'kmob_asset_data_submission_mobile_screen.dart';
import 'kmob_asset_data_submission_tab_screen.dart';
import 'kmob_asset_data_submission_web_screen.dart';

class KMOBAssetDataSubmissionContainerScreen
    extends GetView<BumblebeeKMOBSubmissionController> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return KMOBAssetDataSubmissionWebScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return KMOBAssetDataSubmissionTabScreen();
        }

        return KMOBAssetDataSubmissionMobileScreen();
      },
    );
  }
}
