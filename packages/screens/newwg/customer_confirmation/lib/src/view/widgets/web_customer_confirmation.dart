import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:customer_confirmation/src/constant.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:newwg/config/app_config.dart';

class WebCustomerConfirmation extends GetView<CustomerConfirmationController> {
  const WebCustomerConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isPhoneNumberVerified.value
          ? verificationCodeForm()
          : phoneNumberForm(),
    );
  }

  Container phoneNumberForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      height: 150,
      width: DeasySizeConfigUtils.screenWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              child: Form(
                key: controller.formKey,
                child: phoneNumberTextField(isDisable: false),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 30),
                child: DeasyPrimaryButton(
                  text: Constanta.konfirmasi,
                  color: AppConfig.instance.buttonPrimaryColor,
                  onPressed: () {
                    controller.submitPhoneNumber();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container verificationCodeForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      height: DeasySizeConfigUtils.screenHeight! * 0.48,
      width: DeasySizeConfigUtils.screenWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKeyCodeVerif,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              phoneNumberTextField(isDisable: true),
              const SizedBox(height: 20),
              DeasyTextForm.outlinedTextForm(
                isNoSpaceOnly: true,
                labelText: Constanta.labelCodeVerif,
                labelSize: 14.0,
                fontSize: 12,
                labelFontFamily: FontFamilyTextForm.medium,
                hintText: Constanta.hintCodeVerif,
                controller: controller.codeVerificationController,
                textInputType: TextInputType.number,
                actionKeyboard: TextInputAction.done,
                customValidation: (String code) {
                  return controller.codeVerificationValidator(code);
                },
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: DeasyColor.kpBlue500,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    Constanta.codeVerificationWording,
                    style: const TextStyle(color: DeasyColor.kpBlue500),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 110,
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
      fontSize: 12,
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
