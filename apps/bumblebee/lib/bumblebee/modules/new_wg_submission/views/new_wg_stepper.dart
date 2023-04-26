import 'package:additional_documents/additional_documents.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/constant/content_constant.dart';
import 'package:kreditplus_deasy_mobile/core/constant/icon_constant.dart';
import 'package:newwg/config/app_config.dart';
import 'package:order/order.dart';
import 'package:stepper/controller/stepper_container_controller.dart';
import 'package:stepper/view/stepper_container_screen.dart';
import 'package:verification_customer/verification_customer.dart';

class NewWgStepperScreen extends GetView<StepperContainerController> {
  NewWgStepperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: DeasyResponsive(
            builder: ((context, orientation, screenType) {
              return Column(
                children: [
                  _appBar(),
                  _content(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return StepperContainerScreen(
      screen1: VerificationCustomerScreen(
        onSubmitted: (cId) {
          controller.customerId.value = cId;
          controller.goToDokumenTambahan();
        },
      ),
      screen2: Obx(
        () => AdditionalDocumentsScreen(
          customerId: controller.customerId.value,
        ),
      ),
      screen3: Container(
        color: DeasyColor.neutral50,
        child: OrderScreen(),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      width: 100.w,
      color: DeasyColor.neutral000,
      height: 7.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => _dialogExit(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 3.vmax,
                    color: DeasyColor.neutral800,
                  ),
                ),
                DeasyTextView(
                  text: 'Data Pengajuan Konsumen',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _dialogExit() {
    DeasyBaseDialogs.getInstance().customContentDialog(
      context: Get.context!,
      height: 280,
      content: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconConstant.RESOURCES_ICON_WARNING_PATH),
            const SizedBox(height: 24),
            DeasyTextView(
              text: controller.stepIndex.toInt() == 0
                  ? ContentConstant.cancelActivation
                  : ContentConstant.exitSubmission,
              fontSize: 20,
              maxLines: 3,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DeasyTextView(
              text: controller.stepIndex.toInt() == 0
                  ? ContentConstant.ensureExitSubmission
                  : ContentConstant.goHomeWithLimit,
              fontSize: 14,
              maxLines: 3,
              textAlign: TextAlign.center,
              fontColor: DeasyColor.neutral400,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DeasyPrimaryButton(
                      text: controller.stepIndex.toInt() == 0
                          ? ContentConstant.canceling
                          : ContentConstant.exit,
                      textStyle: TextStyle(
                        color: AppConfig.instance.buttonSecondaryColor,
                        fontSize: 14.sp,
                      ),
                      color: AppConfig.instance.buttonPrimaryColor,
                      onPressed: () {
                        Get.back();
                        Get.back();
                        Get.back();
                      }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: DeasyPrimaryButton(
                    text: ContentConstant.continueProcess,
                    textStyle: TextStyle(
                      color: AppConfig.instance.buttonTextSecondaryColor,
                      fontSize: 14.sp,
                    ),
                    color: AppConfig.instance.buttonSecondaryColor,
                    borderColor: AppConfig.instance.buttonPrimaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
