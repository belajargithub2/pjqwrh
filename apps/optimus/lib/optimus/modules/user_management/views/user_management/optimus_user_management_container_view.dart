import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/controllers/optimus_user_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/views/user_management/widgets/optimus_user_management_mobile_view.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/views/user_management/widgets/optimus_user_management_tab_view.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/views/user_management/widgets/optimus_user_management_web_view.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusUserManagementContainerView
    extends GetView<OptimusUserManagementController> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return LayoutBuilder(
      builder: (context, constraints) {
        DeasySizeConfigUtils.setScreenSize(constraints);
        return OptimusDrawerCustom(
          scaffoldKey: scaffoldKey,
          body: Obx(
            () => controller.isLoading.isTrue
                ? AbsorbPointer(
                    absorbing: true,
                    child: Stack(
                      children: [Container(), FullScreenSpinner()],
                    ),
                  )
                : DeasyResponsive(
                    builder: (context, orientation, screenType) {
                      if (screenType == DeasyScreenType.desktop) {
                        return OptimusUserManagementWebView();
                      }

                      if (screenType == DeasyScreenType.tablet) {
                        return OptimusUserManagementTabView();
                      }

                      return OptimusUserManagementMobileView();
                    },
                  ),
          ),
        );
      },
    );
  }
}
