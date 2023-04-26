import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/controllers/bumblebee_forgot_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

import 'widgets/bumblebee_forgot_password_form_widget.dart';

class BumblebeeForgotPasswordPage
    extends GetView<BumblebeeForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: Get.context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: Material(
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight,
                child: SafeArea(
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
                          top: DeasySizeConfigUtils.screenHeight! / 32,
                          left: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          )),
                      Positioned(
                        top: DeasySizeConfigUtils.screenHeight! / 32,
                        child: Container(
                            width: DeasySizeConfigUtils.screenWidth,
                            child: Center(
                                child: SvgPicture.asset(
                                    'resources/images/deasy_logo.svg'))),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          width: DeasySizeConfigUtils.screenWidth,
                          child: BumblebeeForgotPasswordFormWidget()),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hubungi kami di 1500605',
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                          fontFamily: 'KBFGDisplayLight',
                          color: Theme.of(context).hintColor),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Terdaftar dan\nDiawasi oleh',
                          style: TextStyle(
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.3,
                              fontFamily: 'KBFGDisplayLight',
                              color: Theme.of(context).hintColor),
                        ),
                        Image.asset(
                          'resources/images/ojk.png',
                          width: 80,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text('V ${controller.versionApp.value}'))
                  ],
                ),
              ),
            ),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: DeasyFullScreenLoading(
                    messageLoading: "Mohon menunggu..."))),
          ],
        ),
      ),
    );
  }
}
