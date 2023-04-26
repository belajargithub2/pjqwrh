import 'package:additional_documents/additional_documents.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg/config/base_config.dart';
import 'package:newwg/module/submission/constants/icons.dart';
import 'package:newwg/module/submission/constants/strings.dart';
import 'package:order/order.dart';
import 'package:stepper/stepper.dart';
import 'package:verification_customer/verification_customer.dart';

class SubmissionView extends GetView<StepperContainerController> {
  const SubmissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLibrary.value = true;
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
        child: const OrderScreen(),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      width: 100.w,
      color: AppConfig.instance.appBarColor,
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
            text: StringConstant.consumentDataSubmission,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ],
      ),
    );
  }

  void _dialogExit() {
    DeasyBaseDialogs.getInstance().customContentDialog(
      context: Get.context!,
      content: Obx(
        () => IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(IconConstant.warning),
              const SizedBox(height: 24),
              DeasyTextView(
                text: controller.stepIndex.toInt() == 0
                    ? StringConstant.cancelActivation
                    : StringConstant.exitSubmission,
                fontSize: 20,
                maxLines: 3,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              DeasyTextView(
                text: controller.stepIndex.toInt() == 0
                    ? StringConstant.ensureExitSubmission
                    : StringConstant.goHomeWithLimit,
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
                          ? StringConstant.cancel
                          : StringConstant.exit,
                      textStyle: TextStyle(
                        color: AppConfig.instance.buttonTextPrimaryColor,
                        fontSize: 14.sp,
                      ),
                      color: AppConfig.instance.buttonPrimaryColor,
                      onPressed: () {
                        BaseConfig.invokeMethod('back', controller.stepIndex.toInt());
                        SystemNavigator.pop(animated: true);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: DeasyPrimaryButton(
                      text: StringConstant.continueProcess,
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
      ),
    );
  }
}
