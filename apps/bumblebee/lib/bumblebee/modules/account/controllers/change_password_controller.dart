import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class ChangePasswordController extends GetxController {
  final isLoading = false.obs;
  final passwordChecker = ''.obs;
  final email = ''.obs;
  final userRepository = UserRepository();
  final isTextObscuredConfirmPassword = true.obs;
  final isTextObscuredNewPassword = true.obs;
  final userId = ''.obs;
  final errorMessageFromApi = ''.obs;
  final errorMessageNewPassword = ''.obs;
  final errorMessageConfirmNewPassword = ''.obs;
  final errorMessageProvision = ''.obs;
  final currentPassword = ''.obs;
  final isShowHint = false.obs;

  get showChangePasswordRules => dialogRequirementChangePassword();

  final newPasswordTextEditingController = TextEditingController();
  final confirmNewPasswordTextEditingController = TextEditingController();

  final changePassFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    showChangePasswordRules;
    super.onReady();
  }

  @override
  void dispose() {
    newPasswordTextEditingController.dispose();
    confirmNewPasswordTextEditingController.dispose();
    super.dispose();
  }

  void init() {
    DeasyPocket().getEmail().then((value) {
      email.value = value;
    });

    DeasyPocket().getUserId().then((value) {
      userId.value = value;
    });

    currentPassword.value = Get.arguments['currentPassword'];
  }

  void checkerPassword(String newPassword) {
    submitValidation(newPassword, confirmNewPasswordTextEditingController.text);
    if (newPassword.isNotEmpty) {
      if (newPassword.isPasswordStrength()) {
        passwordChecker.value = ContentConstant.strong;
      } else {
        passwordChecker.value = ContentConstant.weak;
      }
    } else {
      passwordChecker.value = '';
    }
  }

  void changePassword(String newPassword, String confirmNewPassword) async {
    clearErrorMessage();
    isLoading.toggle();
    UserChangePasswordRequest request = UserChangePasswordRequest()
      ..confirmNewPassword = confirmNewPassword
      ..currentPassword = currentPassword.value
      ..newPassword = newPassword
      ..userId = userId.value;
    await userRepository
        .postApiChangePassword(
            Get.context, request.toJson(), "Profile_Change_Password")
        .then((value) async {
      isLoading.toggle();
      if (value.data != null) {
        await AnalyticConfig().sendEventSuccess("Profile_Change_Password");
        Get.offAndToNamed(Routes.RESET_PASSWORD_SUCCESS);
      }
    }).catchError((onError) {
      isLoading.toggle();
      errorMessageFromApi.value = "$onError";
      passwordChecker.value = '';
      AnalyticConfig().sendEventFailed("Profile_Change_Password");
    });
  }

  void clearTextInput(String newPassword, String confirmNewPassword) {
    newPassword = "";
    confirmNewPassword = "";
  }

  void validationNewPassword(String value, String confirmNewPassword) {
    errorMessageNewPassword.value = "";

    if (value.isEmpty) {
      errorMessageNewPassword.value = ContentConstant.passwordRequired;
    }

    if (value != confirmNewPassword &&
        confirmNewPasswordTextEditingController.text.isNotEmpty) {
      errorMessageNewPassword.value = ContentConstant.passwordNotMatch;
    }
  }

  void validationConfirmNewPassword(String value, String newPassword) {
    errorMessageConfirmNewPassword.value = "";

    if (value.isEmpty) {
      errorMessageConfirmNewPassword.value =
          ContentConstant.passwordConfirmRequired;
    }

    if (value != newPassword &&
        confirmNewPasswordTextEditingController.text.isNotEmpty) {
      errorMessageConfirmNewPassword.value =
          ContentConstant.newPasswordNotMatch;
    }
  }

  bool submitValidation(String newPassword, String confirmNewPassword) {
    if (identical(passwordChecker.value, ContentConstant.strong) &&
        newPassword.length > 5 &&
        !newPassword.isContainIgnoreCase("finansia") &&
        newPassword == confirmNewPassword) {
      clearErrorMessage();
      return true;
    } else {
      return false;
    }
  }

  void passwordDoesNotMatchTheProvisions() {
    clearErrorMessage();
    errorMessageProvision.value = ContentConstant.passwordNotAllowed;
  }

  void clearErrorMessage() {
    errorMessageProvision.value = "";
    errorMessageFromApi.value = "";
    errorMessageNewPassword.value = "";
    errorMessageConfirmNewPassword.value = "";
  }

  dialogRequirementChangePassword() {
    return Get.dialog(
      AlertDialog(
        backgroundColor: DeasyColor.neutral000,
        content: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 50, bottom: 24, left: 24, right: 24),
              child: Image.asset(
                  ImageConstant.RESOURCES_IMAGE_REQUIREMENT_CHANGE_PASS),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: DeasyColor.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
