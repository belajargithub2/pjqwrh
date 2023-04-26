import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'widgets/optimus_drawer_item_menu.dart';
import 'widgets/optimus_drawer_logo.dart';
import 'widgets/optimus_drawer_notif_button_widget.dart';
import 'widgets/optimus_drawer_profile_appbar_button_widget.dart';

class OptimusDrawerCustom extends GetView<OptimusDrawerCustomController> {
  Widget? body;
  String parentRoute;
  Key? scaffoldKey = UniqueKey();

  OptimusDrawerCustom({this.body, this.scaffoldKey, this.parentRoute = ""});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OptimusDrawerCustomController());
    DeasySizeConfigUtils().init(context: context);
    controller.calculateSizeScreen();
    return GetBuilder<OptimusDrawerCustomController>(
      init: OptimusDrawerCustomController(),
      builder: (_) => Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            Row(
              children: [
                Obx(() => AnimatedContainer(
                  width: DeasySizeConfigUtils.isMobile
                      ? controller.isOpened.isFalse
                      ? 10
                      : DeasySizeConfigUtils.screenWidth! / 7
                      : DeasySizeConfigUtils.isTab
                      ? controller.isOpened.isFalse
                      ? DeasySizeConfigUtils.screenWidth! / 10
                      : DeasySizeConfigUtils.screenWidth! / 3.5
                      : controller.isOpened.isFalse
                      ? DeasySizeConfigUtils.screenWidth! / 9
                      : DeasySizeConfigUtils.screenWidth! / 4.8,
                  height: DeasySizeConfigUtils.screenHeight,
                  duration: Duration(milliseconds: 500),
                  child: Drawer(
                    child: Container(
                      height: DeasySizeConfigUtils.screenHeight,
                      color: DeasyColor.kpBlue600,
                      padding: EdgeInsets.symmetric(
                          horizontal: DeasySizeConfigUtils.isDesktopOrWeb
                              ? 20
                              : DeasySizeConfigUtils.isTab
                              ? 10
                              : 2),
                      child: Column(
                        children: <Widget>[
                          OptimusDrawerLogo(isOpened: controller.isOpened),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              color: DeasyColor.kpBlue700,
                              thickness: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height:
                              DeasySizeConfigUtils.screenHeight! / 1.4,
                              child: AnimatedSwitcher(
                                switchInCurve: Curves.linearToEaseOut,
                                switchOutCurve: Curves.easeInToLinear,
                                duration: const Duration(milliseconds: 500),
                                child: ListView(
                                  primary: true,
                                  key: UniqueKey(),
                                  children: [
                                    Obx(() => ListView(
                                      shrinkWrap: true,
                                      primary: false,
                                      children: controller.sideMenuList
                                          .map((item) {
                                        return OptimusDrawerItemMenu(
                                          hiddenAppbar: () => controller
                                              .hiddenDropdownAppBar(),
                                          isOpened: controller.isOpened,
                                          parentRoute: parentRoute,
                                          item: item,
                                        );
                                      }).toList(),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                width: DeasySizeConfigUtils.screenWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppBar(
                                      key: UniqueKey(),
                                      elevation: 3,
                                      backgroundColor: DeasyColor.neutral000,
                                      actions: [
                                        OptimusDrawerNotifButtonAppbarWidget(),
                                        OptimusDrawerProfileAppbarButtonWidget()
                                      ],
                                    ),
                                  ],
                                ))),
                        Expanded(flex: 9, child: Container(child: body)),
                      ],
                    ))
              ],
            ),
            Obx(() => AnimatedPositioned(
              left: DeasySizeConfigUtils.isMobile
                  ? controller.isOpened.isFalse
                  ? -5
                  : DeasySizeConfigUtils.screenWidth! / 9.3
                  : DeasySizeConfigUtils.isTab
                  ? controller.isOpened.isFalse
                  ? DeasySizeConfigUtils.screenWidth! / 12
                  : (DeasySizeConfigUtils.screenWidth! / 3.9) + 4
                  : controller.isOpened.isFalse
                  ? (DeasySizeConfigUtils.screenWidth! / 10.5)
                  : (DeasySizeConfigUtils.screenWidth! / 5.1) - 4,
              top: 15,
              duration: const Duration(milliseconds: 500),
              child: InkWell(
                onTap: () {
                  controller.handleIcon();
                },
                child: Card(
                  color: DeasyColor.neutral000,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: RotationTransition(
                      turns: controller.animation,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: DeasyColor.semanticInfo300,
                      ),
                    ),
                  ),
                ),
              ),
            )),
            Obx(() => Visibility(
                visible: controller.isShowLoading.value,
                child: DeasyFullScreenLoading(
                    messageLoading: "Mohon menunggu..."))),
          ],
        ),
      ),
    );
  }
}