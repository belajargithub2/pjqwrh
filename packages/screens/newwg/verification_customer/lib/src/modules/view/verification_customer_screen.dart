import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart' as dt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:verification_customer/src/modules/constans/icons.dart';
import 'package:verification_customer/src/modules/constans/strings.dart';
import 'package:verification_customer/src/modules/controller/verification_customer_controller.dart';
import 'package:verification_customer/src/modules/view/mobile/widgets/image_preview_mobile.dart';
import 'package:verification_customer/src/modules/view/widgets/list_dropdown_mobile.dart';
import 'package:verification_customer/src/modules/view/mobile/widgets/text_verification_customer_mobile.dart';
import 'package:verification_customer/src/modules/view/widgets/text_verification_customer.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:verification_customer/src/modules/view/web/widgets/image_preview_web.dart';
import 'package:verification_customer/src/modules/view/widgets/verification_info.dart';

part 'mobile/verification_customer_mobile_screen.dart';
part 'web/verification_customer_web_screen.dart';

class VerificationCustomerScreen extends GetWidget<VerificationCustomerController> {
  final Function? onSubmitted;
  final Function? onBackToDashboard;
  const VerificationCustomerScreen({super.key, this.onSubmitted, this.onBackToDashboard});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(builder: (context, orientation, screenType) {
      if (screenType == DeasyScreenType.desktop) {
        return VerificationCustomerWebScreen(
          onBackToDashboard: onBackToDashboard,
        );
      }

      return VerificationCustomerMobileScreen(
        onSubmitted: onSubmitted!,
      );
    });
  }
}
