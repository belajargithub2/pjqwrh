import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeeLoginEmailController extends GetxController {
  final isLoading = false.obs;
  BumblebeeLoginRepository _loginRepository;
  MenuRoleRepository _menuRoleRepository;
  final isTextObscured = true.obs;
  final isShowingClearButton = false.obs;
  final formKey = GlobalKey<FormState>();
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  int limitCheckPermission = 0;
  BumblebeeLoginController _loginController =
      Get.find<BumblebeeLoginController>();
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  BumblebeeLoginEmailController({
    required BumblebeeLoginRepository loginRepository,
    required MenuRoleRepository menuRoleRepository,
  })  : _loginRepository = loginRepository,
        _menuRoleRepository = menuRoleRepository;

  @override
  void onInit() {
    super.onInit();
  }

  Future postApiLogin(String email, String password) async {
    isLoading.value = true;

    await _loginRepository
        .postApiLoginUseEmail(Get.context,
            deviceId: _loginController.deviceId,
            email: email,
            password: password,
            eventName: "Login")
        .then((value) async {
      isLoading.value = false;
      if (value.data!.code == ContentConstant.LOGIN_EMAIL_IS_MUTIPLE) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.hasLogin);
      } else if (!_loginController.checkRoleForMobile(value)) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.errorRoleAccess);
      } else {
        AnalyticConfig().sendEventSuccess("Login");
        await onLoginSuccess(value)
            .whenComplete(() => _loginController.navigateToHome());
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("Login");
      isLoading.value = false;
    });
  }

  navigateToRegister() {
    AnalyticConfig().sendEventStart("Register_Deasy");
    Get.toNamed(BumblebeeRoutes.PRE_REGISTER_PAGE);
  }

  Future onLoginSuccess(LoginResponse response) async {
    await _loginController.saveDataToLocalAfterDoLogin(
        response: response.data!, isLoginByEmail: true);
    _loginController.setToModule(response);
    await _menuRoleRepository
        .getDetailRole(Get.context, response.data!.roleId)
        .then((value) {
      _loginController.setToModule(response);
      value.data!.toSharedPref();
      value.data!.dashboardPermission!.toSharedPref();
      value.data!.menuPermission!.toSharedPref();
    });

    isLoading.value = false;
  }

  void handleVerification(String value) {
    if (value == "") {
      isShowingClearButton.value = false;
    } else {
      isShowingClearButton.value = true;
    }
  }

  void clearEmailValue() {
    emailController.text = "";
    isShowingClearButton.value = false;
  }

  String? passwordValidation(String password) {
    if (password.isEmpty) {
      return ContentConstant.badRequestLoginPasswordEmpty;
    }
  }

  void submit() async {
    autoValidate.value = AutovalidateMode.always;
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();
      await postApiLogin(
          emailController.text.trim(), passwordController.text.trim());
    }
  }
}
