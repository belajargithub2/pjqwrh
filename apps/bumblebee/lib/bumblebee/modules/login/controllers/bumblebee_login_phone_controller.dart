import 'dart:async';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/views/widgets/bumblebee_email_verification_dialogs.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/widgets/bumblebee_login_dialog.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';

class BumblebeeLoginPhoneController extends GetxController
    with SingleGetTickerProviderMixin {
  AuthRepository authRepository;
  DeepLinkRepository deepLinkRepository;
  DynamicLinkConfig dynamicLinkConfig;
  BumblebeeLoginRepository _loginRepository;
  MenuRoleRepository? _menuRoleRepository;
  final dialog = Get.find<BumblebeeLoginDialog>();
  final noController = TextEditingController();
  final otpController = TextEditingController();
  final retryAt = 0.obs;
  final second = 60.obs;
  final interval = const Duration(seconds: 1);
  final timerMaxSeconds = 80.obs;
  final currentSeconds = 0.obs;
  final isRequestOTP = false.obs;
  final isShowResendOTP = false.obs;
  final canResendOTP = false.obs;
  final isLoading = false.obs;
  final phoneNumber = ''.obs;
  final onClickSendOtp = false.obs;
  String? version;
  double? latitude;
  double? longitude;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;
  final formKeyLoginWithPhoneNumber = GlobalKey<FormState>();
  BumblebeeLoginController _loginController =
      Get.find<BumblebeeLoginController>();
  Timer? otpTimer;
  bool hasSentOtp = false;
  List<String> otpOptions = ["MISSCALL", "SMS"];
  final selectedOtp = "".obs;
  late String createPasswordUrl;
  late String token;

  BumblebeeLoginPhoneController(
      {AuthRepository? authRepository,
      DeepLinkRepository? deepLinkRepository,
      DynamicLinkConfig? dynamicLinkConfig,
      BumblebeeLoginRepository? loginRepository,
      MenuRoleRepository? menuRoleRepository})
      : authRepository = authRepository!,
        deepLinkRepository = deepLinkRepository!,
        dynamicLinkConfig = dynamicLinkConfig!,
        _loginRepository = loginRepository!,
        _menuRoleRepository = menuRoleRepository;

  @override
  void onInit() {
    super.onInit();
    DeasySizeConfigUtils().init(context: Get.context);
  }

  Future<int?> requestOTP(bool showSnackbar) async {
    int? retryAt = 0;
    if (noController.text.isEmpty) {
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, ContentConstant.cantEmptyPhoneNumber);
    } else if (!noController.text.isIdPhoneNumber()) {
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, ContentConstant.invalidLoginPhoneNumber);
    } else {
      await _loginRepository
          .requestOTP(Get.context, createRequesOTP(), showSnackbar)
          .then((value) {
        if (value.message == "OK") {
          hasSentOtp = true;
          retryAt = value.data!.retryAt;
        }
      }).catchError((e) {
        Get.back();
        isLoading(false);
        if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorPhoneNotRegister)) {
          dialog.alertPhoneNotRegisterDialog();
        }
        if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorRequestLimit)) {
          dialog.alertMaxLimitDialog();
        }
        if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorEmailNotVerified) &&
            e['data']['email'] != null) {
          String email = e['data']['email'];
          dialog.verifyAccountDialog(email, () async {
            Get.back();
            await resendEmail(email);
          });
        }
        throw e;
      });
    }
    return retryAt;
  }

  Future<void> resendEmail(String email) async {
    isLoading(true);
    await setTokenAndUrl(email);
    await sendEmail(email, Uri.parse(createPasswordUrl), token);
  }

  setTokenAndUrl(String email) async {
    token = (await getToken())!;
    createPasswordUrl = await createDynamicLink(token, email);
  }

  Future<String> createDynamicLink(String token, String email) async {
    return await dynamicLinkConfig.createDynamicLink(
        token, deepLinkRepository, email, "create", "new-password");
  }

  Future<String?> getToken() async {
    GetTokenResponse _tokenResponse =
        await authRepository.getTokenEmail(Get.context, null);
    return _tokenResponse.data!.token;
  }

  sendEmail(String email, Uri url, String? token) async {
    await authRepository
      .postPasswordEmail(
          Get.context,
          createRequestPasswordMail(email, url, token),
          "Add_Merchant_Verify_Email")
      .then((value) {
        isLoading(false);
        successResendVerificationEmailDialog(email, () {
          Get.toNamed(
            BumblebeeRoutes.EMAIL_VERIFICATION_PAGE,
            arguments: {
              "email": email,
            }
          );
        });
      }).catchError((_) {
        isLoading(false);
      });
  }

  Map<String, dynamic> createRequestPasswordMail(
      String email, Uri url, String? token) {
    var request = Map<String, String>();
    request["email"] = email;
    request["type"] = "create_password";
    request["url"] = "$url";
    request["token"] = "$token";
    return request;
  }

  Map<String, dynamic> createRequesOTP() {
    var request = Map<String, String>();
    request["phone_number"] = noController.text;
    request["type"] = selectedOtp.value;
    return request;
  }

  Future login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    isLoading.value = true;

    await _loginRepository
        .postApiLoginUsePhoneNumber(context,
            phoneNumber: noController.text,
            otsCode: otpController.text,
            deviceId: _loginController.deviceId,
            eventName: "Login")
        .then((value) async {
      isLoading.value = false;
      if (value.data!.code == ContentConstant.LOGIN_PHONE_NUMBER_IS_MUTIPLE) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.hasLogin);
      } else if (!_loginController.checkRoleForMobile(value)) {
        AnalyticConfig().sendEventFailed("Login");
        DeasySnackBarUtil.showFlushBarError(
            Get.context!, ContentConstant.errorRoleAccess);
      } else {
        AnalyticConfig().sendEventSuccess("Login");
        _loginController.setToModule(value);
        Future.wait([
          _onLoginSuccess(value.data!),
        ]).then((value) {
          _loginController.navigateToHome();
        });
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("Login");
      isLoading.value = false;
    });
  }

  Future<void> _onLoginSuccess(LoginData response) async {
    await _loginController.saveDataToLocalAfterDoLogin(
        response: response, isLoginByEmail: false);
    await _menuRoleRepository!
        .getDetailRole(Get.context, response.roleId)
        .then((value) {
      value.data!.toSharedPref();
      value.data!.dashboardPermission!.toSharedPref();
      value.data!.menuPermission!.toSharedPref();
    });

    isLoading.value = false;
  }

  void submit() async {
    onClickSendOtp(false);
    autoValidate.value = AutovalidateMode.always;
    if (formKeyLoginWithPhoneNumber.currentState!.validate() && hasSentOtp) {
      await login(Get.context!);
    }
  }

  String? phoneNumberValidation(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return ContentConstant.cantEmptyPhoneNumber;
    } else if (!noController.text.isIdPhoneNumber()) {
      return ContentConstant.phoneNumberNotValid;
    } else {
      return null;
    }
  }

  String? otpValidation(String otp) {
    if (otp.isEmpty && onClickSendOtp.isFalse) {
      return ContentConstant.cantEmptyOtp;
    } else {
      return null;
    }
  }

  void preRequestOTP({Function? onFailed}) async {
    var retryAt = await requestOTP(false);
    if (retryAt! > 0) {
      Get.toNamed(
        BumblebeeRoutes.OTP,
        arguments: {
          "phone": noController.text,
          "retry_at": retryAt,
          "type": selectedOtp.value,
        },
      );
    }
  }

  void navigateToRegister() {
    AnalyticConfig().sendEventStart("Register_Deasy");
    Get.toNamed(BumblebeeRoutes.PRE_REGISTER_PAGE);
  }

  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }

  void handleRequestOTP({Function? popup}) {
    onClickSendOtp(true);
    autoValidate.value = AutovalidateMode.always;
    if (formKeyLoginWithPhoneNumber.currentState!.validate()) {
      if (isRequestOTP.isFalse) {
        requestOTP(false);
      }
    }
  }

  void setTimeOut() {
    final currentDate = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(retryAt.value * 1000);
    second.value = date.difference(currentDate).inSeconds;
    timerMaxSeconds.value = second.value;
    startTimeout();
  }

  void startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      otpTimer = timer;
      currentSeconds.value = otpTimer!.tick;
      if (otpTimer!.tick >= timerMaxSeconds.value) {
        timer.cancel();
      }

      if ((timerMaxSeconds.value - currentSeconds.value) == 0) {
        isRequestOTP(false);
        canResendOTP(true);
      }
    });
    isRequestOTP(true);
  }

  void changeOtpOption(String? otp) {
    selectedOtp(otp);
  }

  void handleSelectOtp() {
    if (selectedOtp.value.isEqualIgnoreCase("sms")) {
      AnalyticConfig().sendEventStart("otp_sms");
      preRequestOTP(onFailed: () => _dialogLimitedOtp());
    } else {
      Get.toNamed(
        BumblebeeRoutes.OTP_LANDING,
      );
    }
  }

  void _dialogLimitedOtp() {
    Get.bottomSheet(
      Container(
        width: DeasySizeConfigUtils.screenWidth,
        height: DeasySizeConfigUtils.screenHeight! / 3,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: DeasyTextView(
                    text: ContentConstant.requestOTPLimitTitle,
                    fontSize: DeasySizeConfigUtils.blockVertical * 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.05,
              ),
              DeasyTextView(
                text: ContentConstant.requestOTPLimit,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.05,
              ),
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: DeasyCustomButton(
                    radius: 3,
                    text: "Kembali",
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
  }
}
