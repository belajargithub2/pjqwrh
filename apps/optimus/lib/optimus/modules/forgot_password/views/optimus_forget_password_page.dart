import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/controllers/optimus_forgot_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/widgets/decoration.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:kreditplus_deasy_website/core/widgets/wave_sidebar.dart';

import 'widgets/optimus_forgot_password_form_widget.dart';

class OptimusForgotPasswordPage
    extends GetView<OptimusForgotPasswordController> {
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
              body: DeasyResponsive(
                builder: (context, orientation, screenType) {
                  if (screenType == DeasyScreenType.desktop) {
                    return Row(
                      children: [
                        Expanded(flex: 4, child: WaveSidebar()),
                        Expanded(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 120),
                              child: OptimusForgotPasswordFormWidget(),
                            )),
                      ],
                    );
                  }

                  if (screenType == DeasyScreenType.tablet) {
                    return Row(
                      children: [
                        Expanded(flex: 4, child: WaveSidebar()),
                        Expanded(
                            flex: 7, child: OptimusForgotPasswordFormWidget()),
                      ],
                    );
                  }

                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: DeasySizeConfigUtils.blockVertical * 0.03,
                        ),
                        FadeInAnimation(
                          delay: 1,
                          child: Text(
                            'Lupa Kata Sandi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 3,
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FadeInAnimation(
                          delay: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                                "resources/images/dealer_management.png"),
                          ),
                        ),
                        FadeInAnimation(
                          delay: 3,
                          child: Text(
                            'Lupa Kata Sandi',
                            style: TextStyle(
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2,
                                color: DeasyColor.neutral900),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        OptimusForgotPasswordFormWidget()
                      ],
                    ),
                  );
                },
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
