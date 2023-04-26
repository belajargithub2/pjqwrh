import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/change_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/text_field.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget() as PreferredSizeWidget?,
      body: Container(
        color: DeasyColor.neutral50,
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            _formWidget(),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: FullScreenSpinner())),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _formWidget(),
      ],
    );
  }

  Widget _formWidget() {
    return Container(
        color: DeasyColor.neutral000,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: controller.changePassFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Obx(() => ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DeasyTextForm.outlinedTextForm(
                    labelText: "Kata Sandi Baru",
                    hintText: "Kata Sandi Baru",
                    contentPaddingHorizontal: 16,
                    labelFontFamily: FontFamilyTextForm.medium,
                    obscure: controller.isTextObscuredNewPassword.value,
                    readOnly: false,
                    controller: controller.newPasswordTextEditingController,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String value) {
                      controller.validationNewPassword(
                          value,
                          controller
                              .confirmNewPasswordTextEditingController.text);
                    },
                    trailing: IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: DeasyColor.kpBlue600,
                      ),
                      onPressed: () => controller.showChangePasswordRules,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                          controller.isTextObscuredNewPassword.isFalse
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                          size: 20.0),
                      onTap: () =>
                          controller.isTextObscuredNewPassword.toggle(),
                    ),
                    prefixIcon: null,
                    onChange: (string) {
                      controller.checkerPassword(string);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Visibility(
                        visible: controller.passwordChecker.isNotEmpty,
                        child: Text(
                          'Password Strength : ${controller.passwordChecker.value}',
                          style: TextStyle(
                              fontSize: 12,
                              color: controller.passwordChecker.value
                                      .isContainIgnoreCase("Lemah")
                                  ? DeasyColor.kpYellow500
                                  : DeasyColor.dms2ED477),
                        )),
                  ),
                  Visibility(
                    visible: controller.errorMessageFromApi.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: DeasyTextView(
                        text: "${controller.errorMessageFromApi.value}",
                        fontSize: 12,
                        fontColor: DeasyColor.dmsF46363,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.errorMessageNewPassword.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: DeasyTextView(
                        text: "${controller.errorMessageNewPassword.value}",
                        fontSize: 12,
                        fontColor: DeasyColor.dmsF46363,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.errorMessageProvision.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: DeasyTextView(
                        text: "${controller.errorMessageProvision.value}",
                        fontSize: 12,
                        fontColor: DeasyColor.dmsF46363,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DeasyTextForm.outlinedTextForm(
                    labelText: "Masukan Ulang Kata Sandi Baru",
                    hintText: "Masukan Ulang Kata Sandi Baru",
                    contentPaddingHorizontal: 16,
                    labelFontFamily: FontFamilyTextForm.medium,
                    obscure: controller.isTextObscuredConfirmPassword.value,
                    suffixIcon: GestureDetector(
                      child: Icon(
                          controller.isTextObscuredConfirmPassword.isFalse
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                          size: 20.0),
                      onTap: () =>
                          controller.isTextObscuredConfirmPassword.toggle(),
                    ),
                    readOnly: false,
                    controller:
                        controller.confirmNewPasswordTextEditingController,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String value) {
                      controller.validationConfirmNewPassword(value,
                          controller.newPasswordTextEditingController.text);
                    },
                    prefixIcon: null,
                  ),
                  Visibility(
                    visible:
                        controller.errorMessageConfirmNewPassword.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DeasyTextView(
                        text:
                            "${controller.errorMessageConfirmNewPassword.value}",
                        fontSize: 12,
                        fontColor: DeasyColor.dmsF46363,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DeasyCustomElevatedButton(
                    text: "Ganti Kata Sandi",
                    paddingButton: 15,
                    textColor: DeasyColor.neutral000,
                    borderColor: DeasyColor.kpYellow500,
                    primary: DeasyColor.kpYellow500,
                    onPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.changePassFormKey.currentState!
                              .validate() &&
                          controller.submitValidation(
                              controller.newPasswordTextEditingController.text,
                              controller.confirmNewPasswordTextEditingController
                                  .text)) {
                        controller.changePassword(
                            controller.newPasswordTextEditingController.text,
                            controller
                                .confirmNewPasswordTextEditingController.text);
                      } else {
                        controller.passwordDoesNotMatchTheProvisions();
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              )),
        ));
  }

  Widget _appBarWidget() {
    return AppBar(
      backgroundColor: DeasyColor.neutral000,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Ubah Password',
        style: TextStyle(
            color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
      ),
      elevation: 1,
    );
  }
}