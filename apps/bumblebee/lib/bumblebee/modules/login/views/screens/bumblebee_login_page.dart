import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/widgets/bumblebee_login_email_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/widgets/bumblebee_login_phone_widget.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_color/deasy_color.dart';

class BumblebeeLoginPage extends GetView<BumblebeeLoginController> {
  @override
  Widget build(BuildContext context) {
    controller.getToken(context);
    controller.checkDeleteAccountDynamicLink();
    DeasySizeConfigUtils().init(context: Get.context);
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight,
                child: Stack(
                  children: [
                    Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      height: DeasySizeConfigUtils.screenHeight! / 2,
                      color: DeasyColor.kpBlue200,
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        ImageConstant.RESOURCES_IMAGE_WAVE_ONE_PATH,
                        width: DeasySizeConfigUtils.screenWidth,
                        fit: BoxFit.fill,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        ImageConstant.RESOURCES_IMAGE_WAVE_TWO_PATH,
                        width: DeasySizeConfigUtils.screenWidth,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: DeasySizeConfigUtils.screenHeight! * 0.03,
                      child: Container(
                        width: DeasySizeConfigUtils.screenWidth,
                        child: Center(
                          child: SvgPicture.asset(
                              ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_PATH),
                        ),
                      ),
                    ),
                    Positioned(
                      top: DeasySizeConfigUtils.screenHeight! / 6.5,
                      right: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: DeasyColor.neutral000,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: Colors.black12,
                              style: BorderStyle.solid,
                              width: 1.0),
                        ),
                        height: DeasySizeConfigUtils.screenHeight! / 1.4,
                        child: Column(
                          children: [
                            TabBar(
                              onTap: (index) {
                                controller.sendLoginTabEvent(index);
                              },
                              unselectedLabelColor: DeasyColor.neutral400,
                              indicatorColor: DeasyColor.kpYellow500,
                              labelColor: DeasyColor.kpYellow500,
                              controller: controller.tabController,
                              tabs: [
                                Tab(text: ContentConstant.loginEmailTab),
                                Tab(text: ContentConstant.loginPhoneTab),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: controller.tabController,
                                children: [
                                  BumblebeeLoginEmailWidget(),
                                  BumblebeeLoginPhoneWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }
    );
  }
}
