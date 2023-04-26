import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_branch.dart';
import 'kmob_consumer_data_submission_web_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_marital_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/widgets/kmob_submission_text_field_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:select_dialog/select_dialog.dart';

part 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_consumer_data_submission/kmob_consumer_data_submission_mobile_screen.dart';

part 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_consumer_data_submission/kmob_consumer_data_submission_tab_screen.dart';

class KMOBConsumerDataSubmissionContainerScreen
    extends GetView<BumblebeeKMOBSubmissionController> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return KMOBConsumerDataSubmissionWebScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return KMOBConsumerDataSubmissionTabScreen();
        }

        return KMOBConsumerDataSubmissionMobileScreen();
      },
    );
  }
}
