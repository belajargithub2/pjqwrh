import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/widgets/optimus_role_management_mobile.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/widgets/optimus_role_management_tab.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/widgets/optimus_role_management_web.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/hover.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';

class OptimusRoleManagementWeb
    extends GetView<OptimusRoleManagementController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Obx(
        () => controller.isLoading.isTrue
            ? FullScreenSpinner()
            : Container(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: DeasyColor.neutral100,
                child: ListView(
                  children: [
                    _menuWidget(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: DeasyTextView(
                          text: "Role Management",
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                          fontFamily: FontFamily.bold),
                    ),
                    DeasyResponsive(
                      builder: (context, orientation, screenType) {
                        if (screenType == DeasyScreenType.desktop) {
                          return OptimusRoleManagementWebsiteOrDesktop();
                        }

                        if (screenType == DeasyScreenType.tablet) {
                          return OptimusRoleManagementTab();
                        }

                        return OptimusRoleManagementMobile();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _menuWidget() {
    double size = DeasySizeConfigUtils.blockVertical * 1.6;
    double sizeOnHover = DeasySizeConfigUtils.blockVertical * 1.7;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OnHover(
            builder: (isHovered) {
              return InkWell(
                onTap: () {
                  _drawerController.handleIcon();
                  Get.back();
                  Get.offNamed(Routes.DASHBOARD_WEB);
                },
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                      color: DeasyColor.kpYellow500,
                      fontSize: isHovered ? sizeOnHover : size),
                ),
              );
            },
          ),
          SizedBox(
            width: 4,
          ),
          OnHover(
            builder: (isHovered) {
              return InkWell(
                onTap: () {},
                child: Text(
                  '> Role Management',
                  style: TextStyle(
                      color: DeasyColor.neutral400,
                      fontSize: isHovered ? sizeOnHover : size),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
