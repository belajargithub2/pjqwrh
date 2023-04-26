import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/promo_marketing_screen/bumblebee_snb_base_promo_marketing_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/show_qr_code_screen/bumblebee_snb_base_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/submission_screen/bumblebee_snb_base_submission_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_bottom_sheet_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_how_to_scan_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_step_indicator_base_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_usage_limit_web.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';

class BumblebeeSnapAndBuyContainerScreen
    extends GetView<BumblebeeSnapAndBuyBaseController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DeasyColor.neutral000,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: DeasyColor.neutral900,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Snap and Buy',
          style: TextStyle(color: DeasyColor.neutral900),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideInAnimation(
                        delay: 3,
                        child: BumblebeeStepIndicatorScreen(
                            index: controller.stepIndex.value)),
                    controller.activeMainSection.isBlank!
                        ? Container()
                        : initMainPage(controller.activeMainSection.value),
                    Obx(() {
                      if (controller.isShowDialogPhoneNumberNotFound.isTrue) {
                        controller.isShowDialogPhoneNumberNotFound.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            onSubmit: () {
                              controller.isShowDialogPhoneNumberNotFound.value =
                                  false;
                              Get.back();
                            },
                            imagePath: ImageConstant
                                .RESOURCES_IMAGE_PHONE_NUMBER_NOT_VALID,
                            title: ContentConstant.titlePhoneNumberNotFound,
                            subTitle:
                                ContentConstant.subTitlePhoneNumberNotFound);
                      }
                      if (controller.isShowDialogInsufficientLimit.isTrue) {
                        controller.isShowDialogInsufficientLimit.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            onSubmit: () {
                              controller.isShowDialogInsufficientLimit.value =
                                  false;
                              Get.back();
                            },
                            imagePath:
                                ImageConstant.RESOURCES_IMAGE_NEED_VERIFICATION,
                            title: ContentConstant.titleInsufficientLimit,
                            subTitle:
                                ContentConstant.subtitleInsufficientLimit);
                      }
                      if (controller.isShowDialogNullDataInstallment.isTrue) {
                        controller.isShowDialogNullDataInstallment.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            onSubmit: () {
                              controller.isShowDialogNullDataInstallment.value =
                                  false;
                              Get.back();
                            },
                            imagePath:
                                ImageConstant.RESOURCES_IMAGE_PROMO_NOT_FOUND,
                            title: ContentConstant.titlePromoNotfound,
                            subTitle: ContentConstant.subTitlePromoNotfound);
                      }
                      if (controller.isShowDialogNeedVerification.isTrue) {
                        controller.isShowDialogNeedVerification.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            onSubmit: () {
                              controller.isShowDialogNeedVerification.value =
                                  false;
                              Get.back();
                            },
                            imagePath:
                                ImageConstant.RESOURCES_IMAGE_NEED_VERIFICATION,
                            title: ContentConstant.titleNeedVerification,
                            subTitle: ContentConstant.subTitleNeedVerification);
                      }
                      if (controller.isShowDialogLimitQrCode.isTrue) {
                        controller.isShowDialogLimitQrCode.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            isQrCode: true,
                            onSubmit: () {
                              controller.isShowDialogLimitQrCode.value = false;
                              Get.back();
                              controller.goToSubmissionSection();
                            },
                            onCancel: () {
                              controller.isShowDialogLimitQrCode.value = false;
                              Get.back();
                              Get.back();
                            },
                            submitText: "Ajukan Lagi",
                            cancelText: "Kebali ke Dashboard",
                            imagePath:
                                ImageConstant.RESOURCES_IMAGE_QR_CODE_RUN_OUT,
                            title: ContentConstant.titleQrCodeRunOut,
                            subTitle: ContentConstant.subTitleQrCodeRunOut);
                      }
                      if (controller.isShowDialogLimitCategory.isTrue) {
                        controller.isShowDialogLimitCategory.toggle();
                        return bumblebeeSnbBottomSheet(
                            context: context,
                            onSubmit: () {
                              controller.isShowDialogLimitCategory.value =
                                  false;
                              Get.back();
                            },
                            imagePath:
                                ImageConstant.RESOURCES_IMAGE_PROMO_NOT_FOUND,
                            title: ContentConstant.titleLimitCategory,
                            subTitle: ContentConstant.subTitleLimitCategory);
                      }
                      return SizedBox();
                    })
                  ],
                )),
          ),
          _loadingWidget()
        ],
      ),
    );
  }

  Widget initMainPage(SECTION name) {
    switch (name) {
      case SECTION.SUBMISSION_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: BumblebeeSnbBaseSubmissionScreen());
        }
      case SECTION.PROMO_MARKETING_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: BumblebeeSnbBasePromoMarketingScreen());
        }
      case SECTION.SHOW_QR_CODE_SECTION:
        {
          return SideInAnimation(
              delay: 3, child: BumblebeeSnbBaseShowQrCodeScreen());
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
          return BumblebeeUsageLimitCard();
        }
      case SUB_SECTION.HOW_TO_SCAN:
        {
          return BumblebeeHowToScanWidget();
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
                      BumblebeeStepIndicatorScreen(
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

  Widget _loadingWidget() {
    return Obx(
      () => Visibility(
        visible: controller.isLoading.value,
        child: AbsorbPointer(
          absorbing: true,
          child: FullScreenSpinner(),
        ),
      ),
    );
  }
}
