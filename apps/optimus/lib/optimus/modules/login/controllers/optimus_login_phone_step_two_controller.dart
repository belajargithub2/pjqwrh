import 'dart:async';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/request/otp_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusLoginPhoneStepTwoController extends GetxController {
  OptimusLoginPhoneStepTwoController({
    required this.loginRepository,
    required this.loginController,
    required this.menuRoleRepository,
  });

  OptimusLoginRepository loginRepository;
  OptimusLoginController loginController;
  OptimusMenuRoleRepository menuRoleRepository;

  final dialog = Get.find<OptimusLoginDialog>();
  final deasyPocket = Get.find<DeasyPocket>();
  final snackbar = Get.find<LoginSnackbar>();

  final isLoading = false.obs;
  final phoneNumber = ''.obs;
  final phoneHint = ''.obs;
  final otpCode = ''.obs;
  final requestOtpType = ''.obs;
  final isOnBoardingShow = true.obs;
  final otpArray = <String>['', '', '', '', '', ''].obs;

  final fieldOne = TextEditingController();
  final fieldTwo = TextEditingController();
  final fieldThree = TextEditingController();
  final fieldFour = TextEditingController();
  final fieldFive = TextEditingController();
  final fieldSix = TextEditingController();
  final focusNodeOne = FocusNode();
  final focusNodeTwo = FocusNode();
  final focusNodeThree = FocusNode();
  final focusNodeFour = FocusNode();
  final focusNodeFive = FocusNode();
  final focusNodeSix = FocusNode();

  final lastRequestOtp = 0.obs;
  final otpTimer = Duration(minutes: 5).obs;
  final canRequestOTP = false.obs;

  @override
  void onReady() {
    if (Get.arguments != null) {
      phoneNumber(Get.arguments['phone_number']);
      checkRequestOtpType(requestType: Get.arguments['request_otp_type']);
      initFocusNodeListener();
      getTimerCache();
    } else {
      Get.offNamed(OptimusRoutes.LOGIN);
    }
    super.onReady();
  }

  // ============ check request type ============== //
  void checkRequestOtpType({required String requestType}) {
    if (requestType == ContentConstant.SMSOTP) {
      isOnBoardingShow(false);
      setPhoneNumberHint();
    }
    if (requestType == ContentConstant.MISSCALLOTP) {
      isOnBoardingShow(true);
    }
    requestOtpType(requestType);
  }

  void setPhoneNumberHint() {
    final formatPhone =
        phoneNumber.value.substring(1, phoneNumber.value.length - 4);
    phoneHint(formatPhone + "xxxx");

    phoneHint.value = phoneHint.value
        .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)}-");

    if (phoneHint.value.lastIndexOf('-') == phoneHint.value.length - 1) {
      phoneHint.value =
          phoneHint.value.substring(0, phoneHint.value.length - 1);
    }

    phoneHint("+62-" + phoneHint.value);
  }

  Future<void> getTimerCache() async {
    deasyPocket.getOtpTimer().then((value) {
      if (value != null) {
        lastRequestOtp(value);
        setTimer(value);
      }
    });
  }
  // ============ check request type ============== //

  // ============ Focus Node ============== //
  void initFocusNodeListener() {
    addFocusNodeListener(fieldOne, focusNodeOne);
    addFocusNodeListener(fieldTwo, focusNodeTwo);
    addFocusNodeListener(fieldThree, focusNodeThree);
    addFocusNodeListener(fieldFour, focusNodeFour);
    addFocusNodeListener(fieldFive, focusNodeFive);
    addFocusNodeListener(fieldSix, focusNodeSix);
  }

  void addFocusNodeListener(
    TextEditingController fieldController,
    FocusNode focusNode,
  ) {
    focusNode.addListener(() {
      if (fieldController.text.isNotEmpty && focusNode.hasFocus) {
        fieldController.selection = TextSelection(
            baseOffset: 0, extentOffset: fieldController.text.length);
      }
    });
  }
  // ============ Focus Node ============== //

  // ============ OTP Timer ============== //
  void setTimer(int lastRequestOtpTime) {
    final currentDate = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(lastRequestOtpTime * 1000);
    otpTimer.value = date.difference(currentDate);
  }
  // ============ OTP Timer ============== //

  // ============ Input OTP ============== //
  void setOTPText(String value, int index, BuildContext context) {
    if (value.length == 1) {
      otpArray[index] = value;
      if (index != 5) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).previousFocus();
      }
      otpArray[index] = '';
    }

    checkOTPText(context);
  }

  int checkOTPText(BuildContext context) {
    int _countEmpty = 0;
    otpArray.forEach((element) {
      if (element.isEmpty) {
        _countEmpty++;
      }
    });

    if (_countEmpty == 0) {
      otpCode.value = otpArray.join();
      login(context);
    }
    return _countEmpty;
  }
  // ============ Input OTP ============== //

  // ============ Request OTP ============== //
  void requestCallOtp() async {
    if (lastRequestOtp.value == 0) {
      await requestOTP();
    } else {
      isOnBoardingShow(false);
    }
  }

  Future<void> requestOTP() async {
    isLoading(true);

    final request = OtpRequest(
      phoneNumber: phoneNumber.value,
      type: requestOtpType.value,
    );

    await loginRepository
        .requestOTP(Get.context, request.toJson(), false)
        .then((value) {
      if (value.message == "OK") {
        deasyPocket.setOtpTimer(value.data!.retryAt!);
        setTimer(value.data!.retryAt!);
        canRequestOTP(false);
        isOnBoardingShow(false);
      }
    }).catchError((e) {
      if (e
          .toString()
          .isContainIgnoreCase(ContentConstant.errorPhoneNotRegister)) {
        dialog.alertPhoneNotRegisterDialog();
      }
      if (e.toString().isContainIgnoreCase(ContentConstant.errorRequestLimit)) {
        dialog.alertMaxLimitDialog();
      }
      isLoading(false);
      deasyPocket.removeOtpTimer();
    });

    isLoading(false);
  }

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    isLoading.value = true;

    await loginRepository
        .postApiLoginUsePhoneNumber(context,
            phoneNumber: phoneNumber.value,
            otsCode: otpCode.value,
            deviceId: loginController.deviceId,
            eventName: "Login")
        .then((value) async {
      isLoading.value = false;
      if (value.data!.code == ContentConstant.LOGIN_PHONE_NUMBER_IS_MUTIPLE) {
        AnalyticConfig().sendEventFailed("Login");
        snackbar.showFlushbarError(context, ContentConstant.hasLogin);
      } else if (!loginController.checkRoleForWeb(value)) {
        AnalyticConfig().sendEventFailed("Login");
        snackbar.showFlushbarError(
            context, ContentConstant.errorRoleAccessForWeb);
      } else {
        AnalyticConfig().sendEventSuccess("Login");
        await loginController.setToModule(value);
        Future.wait([
          onLoginSuccess(value.data!),
        ]).then((value) {
          loginController.navigateToHome();
        });
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("Login");
      isLoading.value = false;
    });
  }

  Future<void> onLoginSuccess(LoginData response) async {
    deasyPocket.removeOtpTimer();
    await loginController.saveDataToLocalAfterDoLogin(
        response: response, isLoginByEmail: false);
    await menuRoleRepository
        .getDetailRole(Get.context, response.roleId)
        .then((value) {
      value.data!.toSharedPref();
      value.data!.dashboardPermission!.toSharedPref();
      value.data!.menuPermission!.toSharedPref();
    });

    isLoading.value = false;
  }
}

class LoginSnackbar {
  void showFlushbarError(BuildContext context, String message) {
    DeasySnackBarUtil.showFlushBarError(context, message);
  }
}
