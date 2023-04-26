import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class OptimusDrawerLogo extends StatelessWidget {
  RxBool? isOpened = false.obs;

  OptimusDrawerLogo({this.isOpened});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return DeasySizeConfigUtils.isMobile ? _mobileLogo() : _desktopAndTabLogo();
  }

  Widget _desktopAndTabLogo() {
    return Obx(() => Row(
          mainAxisAlignment: isOpened!.isFalse
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Obx(() => SvgPicture.asset(
                      isOpened!.isFalse
                          ? ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_EXPAND
                          : ImageConstant.RESOURCES_IMAGE_DEASY_LOGO,
                      height: DeasySizeConfigUtils.screenHeight! / 13,
                      width: DeasySizeConfigUtils.screenHeight! / 13,
                      color: DeasyColor.neutral000,
                    )),
              ),
            ),
            Obx(() => isOpened!.isTrue ? Spacer() : Container())
          ],
        ));
  }

  Widget _mobileLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: SvgPicture.asset(
          ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_EXPAND,
          height: DeasySizeConfigUtils.screenWidth! / 10,
          width: DeasySizeConfigUtils.screenHeight! / 10,
          color: DeasyColor.neutral000,
        ),
      ),
    );
  }
}
