import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/constant/menu_constant.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/controllers/merchant_add_user_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/views/widgets/merchant_user_management_dialogs_widget.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:deasy_helper/deasy_helper.dart';

part 'mobile/merchant_user_management_add_mobile_screen.dart';

part 'tab/merchant_user_management_add_tab_screen.dart';

part 'web/merchant_user_management_add_web_screen.dart';

class MerchantUserManagementAddScreen
    extends GetWidget<MerchantAddUserManagementController> {
  @override
  Widget build(BuildContext context) {
    return OptimusDrawerCustom(
      body: Obx(() => controller.isLoading.isTrue ? _loading() : _body()),
    );
  }

  Widget _body() {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return MerchantUserManagementAddWebScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return MerchantUserManagementAddTabScreen();
        }

        return MerchantUserManagementAddMobileScreen();
      },
    );
  }

  Widget _loading() {
    return AbsorbPointer(
      absorbing: true,
      child: Stack(
        children: [Container(), FullScreenSpinner()],
      ),
    );
  }
}
