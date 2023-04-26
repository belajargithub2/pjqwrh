import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/promo_marketing_screen/optimus_snb_base_promo_marketing_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/show_qr_code_screen/optimus_snb_base_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/submission_screen/optimus_snb_base_submission_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_how_to_scan_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_step_indicator_base_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_usage_limit_web.dart';

class OptimusSnapAndBuyContainerScreen
    extends GetView<OptimusSnapAndBuyBaseController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Get.height,
              child: DeasyResponsive(
                builder: (context, orientation, screenType) {
                  if (screenType == DeasyScreenType.desktop) {
                    return _desktopContent();
                  }

                  if (screenType == DeasyScreenType.tablet) {
                    return _tabletContent();
                  }

                  return _mobileContent();
                },
              ),
            ),
            Obx(() {
              if (controller.isShowDialogPhoneNumberNotFound.isTrue) {
                controller.isShowDialogPhoneNumberNotFound.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: DialogConstant.titlePhoneNumberNotFound,
                      subTitle: DialogConstant.subTitlePhoneNumberNotFound,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 350,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                          DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogPhoneNumberNotFound.value =
                            false;
                        Get.back();
                      },
                      buttonOkText: DialogConstant.snbDialogFormPesananButton,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.asset(ImageConstant
                            .RESOURCES_IMAGE_PHONE_NUMBER_NOT_VALID),
                      ));
                });
              }
              if (controller.isShowDialogInsufficientLimit.isTrue) {
                controller.isShowDialogInsufficientLimit.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: DialogConstant.titleInsufficientLimit,
                      subTitle: DialogConstant.subtitleInsufficientLimit,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 350,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                          DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogInsufficientLimit.value = false;
                        Get.back();
                      },
                      buttonOkText: DialogConstant.snbDialogFormPesananButton,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.asset(
                            ImageConstant.RESOURCES_IMAGE_NEED_VERIFICATION),
                      ));
                });
              }
              if (controller.isShowDialogNullDataInstallment.isTrue) {
                controller.isShowDialogNullDataInstallment.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: DialogConstant.titlePromoNotfound,
                      subTitle: DialogConstant.subTitlePromoNotfound,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 350,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                          DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogNullDataInstallment.value =
                            false;
                        Get.back();
                      },
                      buttonOkText: DialogConstant.snbDialogFormPesananButton,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.asset(
                            ImageConstant.RESOURCES_IMAGE_PROMO_NOT_FOUND),
                      ));
                });
              }
              if (controller.isShowDialogNeedVerification.isTrue) {
                controller.isShowDialogNeedVerification.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: DialogConstant.titleNeedVerification,
                      subTitle: DialogConstant.subTitleNeedVerification,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 370,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                          DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogNeedVerification.value = false;
                        Get.back();
                      },
                      buttonOkText: DialogConstant.snbDialogFormPesananButton,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                            ImageConstant.RESOURCES_IMAGE_NEED_VERIFICATION),
                      ));
                });
              }
              if (controller.isShowDialogLimitQrCode.isTrue) {
                controller.isShowDialogLimitQrCode.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: DialogConstant.titleQrCodeRunOut,
                      subTitle: DialogConstant.subTitleQrCodeRunOut,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 370,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                          DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogNeedVerification.value = false;
                        Get.back();
                        controller.goToSubmissionSection();
                      },
                      onPressButtonCancel: () {
                        controller.isShowDialogLimitQrCode.value = false;
                        Get.back();
                        controller.gotoDashboard();
                      },
                      buttonOkText: "Ajukan Lagi",
                      buttonCancelText: "Kembali ke Dashboard",
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                            ImageConstant.RESOURCES_IMAGE_QR_CODE_RUN_OUT),
                      ));
                });
              }
              if (controller.isShowDialogLimitCategory.isTrue) {
                controller.isShowDialogLimitCategory.toggle();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return DeasyBaseDialogs.getInstance().iconDialog(
                      context: Get.context!,
                      title: ContentConstant.titleLimitCategory,
                      subTitle: ContentConstant.subTitleLimitCategory,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 400,
                      fontSizeTitle: DeasySizeConfigUtils.blockVertical * 2.2,
                      fontSizeSubTitle:
                      DeasySizeConfigUtils.blockVertical * 1.8,
                      onPressButtonOk: () {
                        controller.isShowDialogLimitCategory.value =
                        false;
                        Get.back();
                      },
                      buttonOkText: ContentConstant.back,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.asset(ImageConstant
                            .RESOURCES_IMAGE_PROMO_NOT_FOUND),
                      ));
                });
              }
              return SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  Widget initMainPage(SECTION name) {
    switch (name) {
      case SECTION.SUBMISSION_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: OptimusSnbBaseSubmissionScreen());
        }
      case SECTION.PROMO_MARKETING_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: OptimusSnbBasePromoMarketingScreen());
        }
      case SECTION.SHOW_QR_CODE_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: OptimusSnbBaseShowQrCodeScreen());
        }
      default:
        {
          return Text('-');
        }
    }
  }

  Widget activeSubSection(SUB_SECTION subSection) {
    switch (subSection) {
      case SUB_SECTION.USAGE_LIMIT_SUB_SECTION:
        {
          return OptimusUsageLimitCard();
        }
      case SUB_SECTION.HOW_TO_SCAN:
        {
          return OptimusHowToScanWidget();
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _tabletContent() {
    return Container(
      height: 90.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OptimusStepIndicatorScreen(
                          index: controller.stepIndex.value),
                      controller.activeMainSection.isBlank!
                          ? Container()
                          : initMainPage(controller.activeMainSection.value)
                    ],
                  ),
                )),
          ),
          SvgPicture.asset(ImageConstant.RESOURCES_IMAGE_LINE_BACKGROUND),
          Expanded(
              child: Obx(
                  () => activeSubSection(controller.activeSubSection.value)),
              flex: 1)
        ],
      ),
    );
  }

  Widget _desktopContent() {
    return Container(
      height: 90.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OptimusStepIndicatorScreen(
                          index: controller.stepIndex.value),
                      controller.activeMainSection.isBlank!
                          ? Container()
                          : initMainPage(controller.activeMainSection.value)
                    ],
                  ),
                )),
          ),
          SvgPicture.asset(ImageConstant.RESOURCES_IMAGE_LINE_BACKGROUND),
          Expanded(
              child: Obx(
                  () => activeSubSection(controller.activeSubSection.value)),
              flex: 1)
        ],
      ),
    );
  }

  Widget _mobileContent() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptimusStepIndicatorScreen(index: controller.stepIndex.value),
          controller.activeMainSection.isBlank!
              ? Container()
              : Expanded(
                  child: initMainPage(controller.activeMainSection.value),
                ),
          activeSubSection(controller.activeSubSection.value)
        ],
      ),
    );
  }
}
