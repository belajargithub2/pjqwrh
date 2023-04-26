import 'package:additional_documents/src/modules/constans/enums.dart';
import 'package:additional_documents/src/modules/view/widgets/frame_preview_mobile.dart';
import 'package:additional_documents/src/modules/view/widgets/image_preview.dart';
import 'package:additional_documents/src/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:flutter/foundation.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart' as dt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:additional_documents/src/modules/constans/strings.dart';
import 'package:additional_documents/src/modules/controller/additional_documents_controller.dart';
import 'package:newwg/config/app_config.dart';

part 'mobile/additional_documents_mobile_screen.dart';

part 'web/additional_documents_web_screen.dart';

class AdditionalDocumentsScreen
    extends GetWidget<AdditionalDocumentsController> {
  final int? customerId;

  const AdditionalDocumentsScreen({super.key, this.customerId});

  @override
  Widget build(BuildContext context) {
    controller.setCustomerId(customerId);
    return DeasyResponsive(builder: (context, orientation, screenType) {
      if (screenType == DeasyScreenType.desktop) {
        return const AdditionalDocumentsWebScreen();
      }

      return const AdditionalDocumentsMobileScreen();
    });
  }
}
