import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptimusLoginEmailController extends GetxController {
  final isLoading = false.obs;
  OptimusLoginRepository _loginRepository;
  OptimusMenuRoleRepository _menuRoleRepository;
  final isTextObscured = true.obs;
  final isShowingClearButton = false.obs;
  final formKey = GlobalKey<FormState>();
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  int limitCheckPermission = 0;
  OptimusLoginController _loginController = Get.find<OptimusLoginController>();
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  OptimusLoginEmailController({
    required OptimusLoginRepository loginRepository,
    required OptimusMenuRoleRepository menuRoleRepository,
  }) : _loginRepository = loginRepository, _menuRoleRepository = menuRoleRepository;

  @override
  void onInit() {
    super.onInit();
  }

  Future postApiLogin(String email, String password) async {
    isLoading.value = true;

    await _loginRepository.postApiLoginUseEmail(Get.context, deviceId: _loginController.deviceId, email: email, password: password, eventName: "Login").then((value) async {
      isLoading.value = false;
      if (value.data!.code == ContentConstant.LOGIN_EMAIL_IS_MUTIPLE) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.hasLogin);
      } else if (!_loginController.checkRoleForWeb(value)) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.errorRoleAccessForWeb);
      } else {
        AnalyticConfig().sendEventSuccess("Login");
        await onLoginSuccess(value).whenComplete(() => _loginController.navigateToHome());
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("Login");
      isLoading.value = false;
    });
  }

  navigateToRegister() {
    AnalyticConfig().sendEventStart("Register_Deasy");
    Get.toNamed(OptimusRoutes.REGISTER_MERCHANT_PAGE);
  }

  Future onLoginSuccess(OptimusLoginResponse response) async {
    await _loginController.saveDataToLocalAfterDoLogin(response: response.data!, isLoginByEmail: true);
    await _loginController.setToModule(response);
    await _menuRoleRepository.getDetailRole(Get.context, response.data!.roleId).then((value) {
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
      return ValidationConstant.badRequestLoginPasswordEmpty;
    }
  }

  void submit() async {
    autoValidate.value = AutovalidateMode.always;
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();
      await postApiLogin(emailController.text.trim(), passwordController.text.trim());
    }
  }
}
