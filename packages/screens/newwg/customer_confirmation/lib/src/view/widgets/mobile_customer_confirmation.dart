import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:customer_confirmation/src/constant.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:newwg/config/app_config.dart';

class MobileCustomerConfirmation
    extends GetView<CustomerConfirmationController> {
  const MobileCustomerConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _content(),
        _loading()
      ],
    );
  }

  Widget _content() {
    return Obx(
          () => controller.isPhoneNumberVerified.value
          ? verificationCodeForm()
          : phoneNumberForm(),
    );
  }

  Widget _loading() {
    return Obx(
          () => controller.isLoading.value
          ? FullScreenSpinner()
          : const SizedBox(),
    );
  }

  Widget phoneNumberForm() {
    return SizedBox(
      height: DeasySizeConfigUtils.screenHeight,
      width: DeasySizeConfigUtils.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: DeasyColor.neutral000,
            child: Form(
              key: controller.formKey,
              child: phoneNumberTextField(isDisable: false),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: DeasyColor.neutral000,
            child: DeasyPrimaryButton(
              text: Constanta.konfirmasi,
              color: AppConfig.instance.buttonPrimaryColor,
              onPressed: () {
                controller.submitPhoneNumber();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget verificationCodeForm() {
    return SizedBox(
      height: DeasySizeConfigUtils.screenHeight,
      width: DeasySizeConfigUtils.screenWidth,
      child: Form(
        key: controller.formKeyCodeVerif,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: DeasyColor.neutral000,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  phoneNumberTextField(isDisable: true),
                  const SizedBox(height: 20),
                  DeasyTextForm.outlinedTextForm(
                    isNoSpaceOnly: true,
                    labelText: Constanta.labelCodeVerif,
                    labelSize: 14.0,
                    fontSize: 14,
                    labelFontFamily: FontFamilyTextForm.medium,
                    hintText: Constanta.hintCodeVerif,
                    controller: controller.codeVerificationController,
                    textInputType: TextInputType.number,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String code) {
                      return controller.codeVerificationValidator(code);
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: DeasyColor.kpBlue500,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: DeasySizeConfigUtils.screenWidth! - 70,
                        child: Text(
                          Constanta.codeVerificationWording,
                          style: const TextStyle(color: DeasyColor.kpBlue500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: DeasyColor.neutral000,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: DeasyPrimaryButton(
                text: Constanta.konfirmasi,
                color: AppConfig.instance.buttonPrimaryColor,
                onPressed: () {
                  controller.submitCodeVerification();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DeasyTextForm phoneNumberTextField({required bool isDisable}) {
    return DeasyTextForm.outlinedTextForm(
      isDisabled: isDisable,
      readOnly: isDisable,
      maxInputLength: 14,
      isNoSpaceOnly: true,
      labelText: Constanta.labelPhoneNumber,
      labelSize: 14.0,
      fontSize: 14,
      labelFontFamily: FontFamilyTextForm.medium,
      hintText: isDisable
          ? controller.phoneNumberController.text
          : Constanta.hintPhoneNumber,
      controller: controller.phoneNumberController,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      customValidation: (String phoneNumber) =>
          controller.phoneNumberValidator(phoneNumber),
    );
  }
}
