import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/automail/responsive/optimus_automail_web.dart';

class OptimusAutomailScreen extends GetView<OptimusAutomailController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  OptimusAutomailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Obx(
        () => controller.isLoading.isTrue
            ? FullScreenSpinner()
            : AutomailWidget(),
      ),
    );
  }

  Widget AutomailWidget() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: DeasyColor.neutral100,
      child: ListView(
        children: [
          _menuWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: DeasyTextView(
                text: "Automail",
                fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                fontFamily: FontFamily.bold),
          ),
          DeasyResponsive(
            builder: (context, orientation, screenType) {
              if (screenType == DeasyScreenType.desktop) {
                return OptimusAutomailWebOrDesktop();
              }

              if (screenType == DeasyScreenType.tablet) {
                return OptimusAutomailWebOrDesktop();
              }

              return OptimusAutomailWebOrDesktop();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.setting,
      menuNameThree: MenuConstant.automail,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: null,
    );
  }
}
