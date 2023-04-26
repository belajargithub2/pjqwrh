import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:stepper/controller/stepper_container_controller.dart';
import 'package:stepper/widget/step_indicator/step_indicator_widget.dart';

class StepperContainerScreen extends GetView<StepperContainerController> {
  const StepperContainerScreen({
    required this.screen1,
    required this.screen2,
    required this.screen3,
    super.key,
  });

  final Widget screen1;
  final Widget screen2;
  final Widget screen3;

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return _desktopContent();
        }

        if (screenType == DeasyScreenType.tablet) {
          return _tabletContent();
        }

        return _mobileContent();
      },
    );
  }

  Widget initMainPage(SECTION name) {
    switch (name) {
      case SECTION.VERIFIKASI_DATA_KONSUMEN:
        {
          return SideInAnimation(delay: 3, child: screen1);
        }
      case SECTION.DOKUMEN_TAMBAHAN:
        {
          return SideInAnimation(delay: 3, child: screen2);
        }
      case SECTION.PESANAN:
        {
          return SideInAnimation(delay: 3, child: screen3);
        }
      default:
        {
          return Text('-');
        }
    }
  }

  Widget _tabletContent() {
    return SizedBox(
      height: 90.h,
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepIndicatorWidget(
                index: controller.stepIndex.value,
                activeColor: AppConfig.instance.stepperActiveColor,
              ),
              controller.activeMainSection.isBlank!
                  ? Container()
                  : initMainPage(controller.activeMainSection.value)
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopContent() {
    return SizedBox(
      height: 90.h,
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: controller.isShowIndicator.isTrue,
                child: StepIndicatorWidget(
                  index: controller.stepIndex.value,
                  activeColor: AppConfig.instance.stepperActiveColor,
                ),
              ),
              controller.activeMainSection.isBlank!
                  ? Container()
                  : initMainPage(controller.activeMainSection.value)
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileContent() {
    return Obx(
          () => Column(
        children: [
          Visibility(
            visible: controller.isShowIndicator.isTrue,
            child: StepIndicatorWidget(
              index: controller.stepIndex.value,
              activeColor: AppConfig.instance.stepperActiveColor,
            ),
          ),
          controller.activeMainSection.isBlank!
              ? Container()
              : initMainPage(controller.activeMainSection.value),
        ],
      ),
    );
  }
}
