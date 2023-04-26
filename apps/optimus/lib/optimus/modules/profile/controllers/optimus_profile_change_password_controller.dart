import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/core/model/user/user_change_password_request.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class OptimusProfileChangePasswordController extends GetxController {
  final userRepository = UserRepository();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final isNewPassObscured = true.obs;
  final isConfirmPassObscured = true.obs;
  RxString userId = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await DeasyPocket().getUserId().then((value) {
      userId.value = value;
    });
    super.onInit();
  }

  String? validate(String text, bool isNewPassword) {
    if (text.isEmpty) {
      return ContentConstant.errorNeedToFillForm;
    } else if (isNewPassword &&
        (newPasswordController.text != confirmNewPasswordController.text)) {
      return ContentConstant.errorPasswordNotSame;
    } else if (text.toString().length < 6) {
      return ContentConstant.errorValidationNewPassword;
    } else if (text.isContainIgnoreCase("finansia")) {
      return ContentConstant.errorValidationNewPassword;
    } else if (!text.isPasswordFormatCorrect()) {
      return ContentConstant.errorValidationNewPassword;
    }

    return null;
  }

  void changePassword() async {
    isLoading.toggle();
    if (confirmNewPasswordController.text.isNotEmpty &&
        currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty) {
      try {
        if (newPasswordController.text == confirmNewPasswordController.text) {
          UserChangePasswordRequest request = UserChangePasswordRequest()
            ..confirmNewPassword = confirmNewPasswordController.text
            ..currentPassword = currentPasswordController.text
            ..newPassword = newPasswordController.text
            ..userId = userId.value;
          await userRepository
              .postApiChangePassword(
                  Get.context, request.toJson(), "Profile_Change_Password")
              .then((value) {
            isLoading.toggle();
            if (value.data != null) {
              AnalyticConfig().sendEventSuccess("Profile_Change_Password");
              showSuccessDialog();
            }
          });
        } else {
          isLoading.toggle();
          Get.rawSnackbar(
              messageText: Text(
                ContentConstant.errorPasswordNotSame,
                style: TextStyle(color: DeasyColor.neutral000),
              ),
              icon: Image.asset(IconConstant.RESOURCES_ICON_ALERT_PATH,
                  height: 16, width: 16),
              snackPosition: SnackPosition.TOP,
              backgroundColor: DeasyColor.dmsF46363);
        }
      } catch (e) {
        AnalyticConfig().sendEventFailed("Profile_Change_Password");
        isLoading.toggle();

        String errorMessage = e.toString();

        if (e.toString().isContainIgnoreCase(
                ContentConstant.errorPasswordAlreadyUsedResponse) ||
            e.toString().isContainIgnoreCase(
                ContentConstant.errorIncorrectPasswordResponse)) {
          errorMessage = ContentConstant.errorPasswordAlreadyUsed;
        } else if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorBadRequestResponse)) {
          errorMessage = ContentConstant.errorPasswordNotSame;
        }

        Get.rawSnackbar(
            messageText: Text(
              errorMessage,
              style: TextStyle(color: DeasyColor.neutral000),
            ),
            icon: Image.asset(IconConstant.RESOURCES_ICON_ALERT_PATH,
                height: 16, width: 16),
            snackPosition: SnackPosition.TOP,
            backgroundColor: DeasyColor.dmsF46363);
      }
    } else {
      isLoading.toggle();
      Get.rawSnackbar(
          messageText: Text(
            'Mohon isi semua form',
            style: TextStyle(color: DeasyColor.neutral000),
          ),
          icon: Image.asset(IconConstant.RESOURCES_ICON_ALERT_PATH,
              height: 16, width: 16),
          snackPosition: SnackPosition.TOP,
          backgroundColor: DeasyColor.dmsF46363);
    }
  }

  void showSuccessDialog() {
    Get.dialog(Dialog(
      child: Container(
        height: Get.height / 2,
        width: Get.width / 3,
        decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      '${ImageConstant.RESOURCES_IMAGES_PATH}password_changed_success.png',
                      height: 245,
                    ),
                    const SizedBox(height: 15),
                    DeasyTextView(
                      text: ContentConstant.passwordChangedSuccess,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.px,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  clearForm();
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: DeasyColor.neutral900,
                )),
          ],
        ),
      ),
    ));
  }

  void clearForm() {
    confirmNewPasswordController.clear();
    currentPasswordController.clear();
    newPasswordController.clear();
  }
}
