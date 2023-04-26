import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/controllers/bumblebee_splash_screen_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/views/widgets/animation/bumblebee_animation.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';

class BumblebeeSplashScreen extends GetView<BumblebeeSplashScreenController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: Material(
        child: Container(
          color: Theme.of(context).accentColor,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Stack(
          children: [
            Container(
              width: DeasySizeConfigUtils.screenWidth,
              child: Column(
                children: [
                  SvgPicture.asset(
                    ImageConstant.RESOURCES_IMAGES_RETANGLE_SPLASH_PATH,
                    width: DeasySizeConfigUtils.screenWidth,
                    fit: BoxFit.fill,
                  ),
                  Stack(
                    children: [
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
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 200,
                  height: 200,
                  child:
                      SvgPicture.asset(ImageConstant.RESOURCES_IMAGE_NEW_LOGO)),
            ),
            Positioned(
              bottom: 70,
              child: Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ContentConstant.callOurHotline,
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
                          ContentConstant.registeredAndSupervisedBy,
                          style: TextStyle(
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.3,
                              fontFamily: 'KBFGDisplayLight',
                              color: Theme.of(context).hintColor),
                        ),
                        Image.asset(
                          ImageConstant.RESOURCES_IMAGE_OJK_PATH,
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
            Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  ImageConstant.RESOURCES_IMAGE_WAVE_ONE_PATH,
                  width: DeasySizeConfigUtils.screenWidth,
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                ImageConstant.RESOURCES_IMAGE_WAVE_TWO_PATH,
                width: DeasySizeConfigUtils.screenWidth,
                fit: BoxFit.fill,
              ),
            ),
          ],
        )),
        AnimationScreen(color: DeasyColor.neutral000)
      ],
    );
  }
}
