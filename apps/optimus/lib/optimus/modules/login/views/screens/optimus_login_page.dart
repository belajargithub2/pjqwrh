import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_card_widget.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/wave_sidebar.dart';

class OptimusLoginPage extends GetView<OptimusLoginController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DeasyResponsive(
          builder: (context, orientation, screenType) {
            if (screenType == DeasyScreenType.desktop) {
              return Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: WaveSidebar(
                        name: DeasySizeConfigUtils.isTab
                            ? ContentConstant.deasyWelcomeTab
                            : ContentConstant.deasyWelcomeDesktop,
                      )),
                  Expanded(flex: 7, child: OptimusLoginCardWidget()),
                ],
              );
            }

            if (screenType == DeasyScreenType.tablet) {
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: WaveSidebar(
                      name: DeasySizeConfigUtils.isTab
                          ? ContentConstant.deasyWelcomeTab
                          : ContentConstant.deasyWelcomeDesktop,
                    ),
                  ),
                  Expanded(flex: 7, child: OptimusLoginCardWidget()),
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
                    child: DeasyTextView(
                      text: '${ContentConstant.DEASY_WELCOME}',
                      textAlign: TextAlign.center,
                      fontSize: DeasySizeConfigUtils.blockVertical * 3,
                      fontColor: DeasyColor.neutral900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(ImageConstant.RESOURCES_IMG_WELCOME),
                    ),
                  ),
                  FadeInAnimation(
                    delay: 3,
                    child: DeasyTextView(
                      text: '${ContentConstant.DEALER_MANAGEMENT}',
                      fontSize: DeasySizeConfigUtils.blockVertical * 2,
                      fontColor: DeasyColor.neutral900,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  OptimusLoginCardWidget()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
