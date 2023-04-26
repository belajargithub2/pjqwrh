import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/controllers/bumblebee_register_merchant_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_animation/deasy_animation.dart';

class PreRegisterPage extends GetView<BumblebeeRegisterMerchantController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: DeasySizeConfigUtils.screenWidth,
          height: DeasySizeConfigUtils.screenHeight,
          child: Stack(
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  '${ImageConstant.RESOURCES_IMAGES_PATH}wave_splash_bottom_one.svg',
                  width: DeasySizeConfigUtils.screenWidth,
                  fit: BoxFit.fill,
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  'resources/images/wave_splash_bottom_two.svg',
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
                            'resources/images/deasy_logo.svg'))),
              ),
              Positioned(
                top: DeasySizeConfigUtils.screenHeight! / 6.5,
                right: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 57, horizontal: 40),
                  height: DeasySizeConfigUtils.screenHeight! / 1.6,
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'Daftar Sebagai',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20),
                      )),
                      SizedBox(height: 24),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeasyRoundedSelectionButton(
                                btnImage:
                                    'resources/images/img_register_agent.png',
                                btnTitle: 'Agent',
                                onPressed: () =>
                                    controller.onPressedButtonRegisterType(
                                        UserType.agent.name),
                                sideColor: controller.onSelectedButton.value
                                        .isContainIgnoreCase(
                                            UserType.agent.name)
                                    ? DeasyColor.kpBlue200
                                    : DeasyColor.neutral000,
                              ),
                              DeasyRoundedSelectionButton(
                                btnImage:
                                    'resources/images/img_register_merchant.png',
                                btnTitle: 'Merchant',
                                sideColor: controller.onSelectedButton.value
                                        .isContainIgnoreCase(
                                            UserType.merchant.name)
                                    ? DeasyColor.kpBlue200
                                    : DeasyColor.neutral000,
                                onPressed: () {
                                  controller.onPressedButtonRegisterType(
                                      UserType.merchant.name);
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: DeasySizeConfigUtils.screenHeight! / 20,
                child: FadeInAnimation(
                  delay: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Obx(
                        () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: controller.onSelectedButton.isEmpty
                                  ? DeasyColor.neutral400
                                  : DeasyColor.kpYellow500,
                              minimumSize: Size(
                                  DeasySizeConfigUtils.screenWidth! - 32, 48),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () =>
                                controller.onRouteToRegisterAsTypeUser(
                                    controller.onSelectedButton.value),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Lanjutkan Pendaftaran",
                                style: TextStyle(color: DeasyColor.neutral000),
                              ),
                            )),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
