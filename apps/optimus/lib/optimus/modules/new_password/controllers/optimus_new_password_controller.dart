import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OptimusNewPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final authRepository = new AuthRepository();
  final isLoading = false.obs;
  final key = ''.obs;
  final flag = ''.obs;
  final passwordChecker = ''.obs;
  final appVersion = ''.obs;
  final isTextObscuredNewPassword = true.obs;
  final isTextObscuredConfirmPassword = true.obs;
  final formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  get showChangePasswordRules => dialogRequirementChangePassword();

  @override
  void onInit() {
    DeasySizeConfigUtils().init(context: Get.context);
    getVersion();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    update();
  }

  void retrieveDeepLink() {
    key.value = Get.parameters['key'] == null ? '' : Get.parameters['key']!;
    emailController.text =
        Get.parameters['email'] == null ? '' : Get.parameters['email']!;
    flag.value = Get.parameters['flag'] == null ? '' : Get.parameters['flag']!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  void submit() {
    autoValidate.value = AutovalidateMode.always;
    if (formKey.currentState!.validate()) {
      resetPassword();
    }
  }

  String? validate(String text, bool isNewPassword) {
    if (text.isEmpty) {
      return ValidationConstant.badRequestLoginPasswordEmpty;
    } else if (text.toString().length < 6) {
      return ContentConstant.passwordNotAllowed;
    } else if (isNewPassword &&
        (passwordController.text != newPasswordController.text)) {
      return "Kata Sandi yang kamu masukkan tidak sama";
    } else if (text.isContainIgnoreCase("finansia")) {
      return ContentConstant.passwordNotAllowed;
    } else if (!text.contains(RegExp(
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$'))) {
      return ContentConstant.passwordNotAllowed;
    }

    return null;
  }

  void checkerPassword(String newPassword) {
    if (newPassword.isNotEmpty) {
      if (newPassword.contains(RegExp(
          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$'))) {
        passwordChecker.value = 'Kuat';
      } else {
        passwordChecker.value = 'Lemah';
      }
    } else {
      passwordChecker.value = '';
    }
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, String>();
    request["confirm_password"] = newPasswordController.text;
    request["email"] = emailController.text;
    request["password"] = newPasswordController.text;
    request["token"] = key.value;
    return request;
  }

  void resetPassword() {
    String eventName = flag.value.isContainIgnoreCase('create')
        ? "Reg_Merch_Set_Pass"
        : "F_Pass_Create_New_Password";
    isLoading(true);
    authRepository
        .postResetPassword(Get.context, createRequest(), eventName)
        .then((value) {
      isLoading(false);
      update();
      AnalyticConfig().sendEventSuccess(eventName);
      showDialogWeb();
    }).catchError((onError) async {
      await AnalyticConfig().sendEventFailed(eventName);
      isLoading(false);
    });
  }

  showDialogWeb() {
    showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              backgroundColor: DeasyColor.neutral000,
              title: Row(
                children: [
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: DeasyColor.neutral900,
                    ),
                    onPressed: () async {
                      String completeEventName =
                          flag.value.isContainIgnoreCase('create')
                              ? "Register_Merchant_Complete"
                              : "Forgot_Password_Complete";
                      await AnalyticConfig().sendEvent(completeEventName);
                      Get.offAllNamed(OptimusRoutes.LOGIN);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              content: Container(
                width: Get.width / 3,
                height: Get.height / 2,
                child: Column(
                  children: [
                    Image.asset(
                      "resources/images/success_verif.png",
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        'Kata Sandi Anda telah berhasil diubah.\nSilakan melakukan login kembali.',
                        style: TextStyle(
                            fontSize: 15, color: DeasyColor.neutral900),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  void clear() {
    newPasswordController.clear();
    passwordController.clear();
    newPasswordController.clear();
  }

  void toggleConfirmPasswordObscure() {
    isTextObscuredConfirmPassword.toggle();
  }

  void toggleNewPasswordObscure() {
    isTextObscuredNewPassword.toggle();
  }

  dialogRequirementChangePassword() {
    return Get.dialog(AlertDialog(
        backgroundColor: DeasyColor.neutral000,
        content: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 50, bottom: 24, left: 24, right: 24),
              child: Image.asset(
                  'resources/images/img_requirement_change_pass.png'),
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: DeasyColor.neutral900,
                )),
          ],
        )));
  }
}
