import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';

import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/views/widgets/optimus_email_verification_dialogs_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/request/otp_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusLoginPhoneStepOneController extends GetxController {
  OptimusLoginPhoneStepOneController({
    required this.authRepository,
    required this.deepLinkRepository,
    required this.dynamicLinkConfig,
    required this.loginRepository
  });

  AuthRepository authRepository;
  DeepLinkRepository deepLinkRepository;
  DynamicLinkConfig dynamicLinkConfig;
  OptimusLoginRepository loginRepository;
  final dialog = Get.find<OptimusLoginDialog>();
  final deasyPocket = Get.find<DeasyPocket>();

  final noController = TextEditingController();
  final autoValidate = AutovalidateMode.disabled.obs;
  final formKeyLoginWithPhoneNumber = GlobalKey<FormState>();
  final isShowOtpTypeOption = false.obs;
  final phoneHint = "".obs;
  final isLoading = false.obs;

  int? otpTime;
  late String createPasswordUrl;
  late String token;

  @override
  void onInit() {
    deasyPocket.getOtpTimer().then((value) => otpTime = value);
    super.onInit();
  }

  void submitPhoneNumber() async {
    autoValidate.value = AutovalidateMode.always;
    if (formKeyLoginWithPhoneNumber.currentState!.validate()) {
      isShowOtpTypeOption(true);
      setPhoneNumberHint();
    }
  }

  String? phoneNumberValidation(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return ValidationConstant.cantEmptyPhoneNumber;
    } else if (!phoneNumber.isIdPhoneNumber()) {
      return ValidationConstant.phoneNumberNotValid;
    } else {
      return null;
    }
  }

  void setPhoneNumberHint() {
    final formatPhone =
        noController.text.substring(1, noController.text.length - 4);
    phoneHint(formatPhone + "xxxx");

    phoneHint.value = phoneHint.value
        .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)}-");

    if (phoneHint.value.lastIndexOf('-') == phoneHint.value.length - 1) {
      phoneHint.value =
          phoneHint.value.substring(0, phoneHint.value.length - 1);
    }

    phoneHint("+62-" + phoneHint.value);
  }

  Future<String> requestOTP(String requestOtpType) async {
    isLoading(true);
    var result;

    if (requestOtpType == ContentConstant.MISSCALLOTP) {
      handleMissCallRequest(requestOtpType);
      result = ContentConstant.MISSCALLOTP;
    } else {
      await handleSmsRequest(requestOtpType);
      result = ContentConstant.SMSOTP;
    }
    isLoading(false);
    return result;
  }

  void handleMissCallRequest(String requestOtpType) {
    Get.toNamed(
      OptimusRoutes.LOGIN_OTP,
      arguments: {
        'phone_number': noController.text,
        'request_otp_type': requestOtpType,
      },
    );
  }

  Future<void> handleSmsRequest(String requestOtpType) async {
    if (otpTime == null) {
      final request = OtpRequest(
        phoneNumber: noController.text,
        type: requestOtpType,
      );

      await loginRepository
          .requestOTP(Get.context, request.toJson(), false)
          .then((value) {
        if (value.message == "OK") {
          deasyPocket.setOtpTimer(value.data!.retryAt!);
          otpTime = value.data!.retryAt!;
          Get.toNamed(
            OptimusRoutes.LOGIN_OTP,
            arguments: {
              'phone_number': noController.text,
              'request_otp_type': requestOtpType,
            },
          );
        }
      }).catchError((e) {
        if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorPhoneNotRegister)) {
          isLoading(false);
          isShowOtpTypeOption(false);
          dialog.alertPhoneNotRegisterDialog();
        }
        if (e
            .toString()
            .isContainIgnoreCase(ContentConstant.errorRequestLimit)) {
          isLoading(false);
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

        deasyPocket.removeOtpTimer();
      });
    } else {
      Get.toNamed(
        OptimusRoutes.LOGIN_OTP,
        arguments: {
          'phone_number': noController.text,
          'request_otp_type': requestOtpType,
        },
      );
    }
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
        isShowOtpTypeOption(false);
        successResendVerificationEmailDialog(email, () {
          Get.toNamed(
            OptimusRoutes.EMAIL_VERIFICATION_PAGE,
            parameters: {
              "email": email,
            }
          );
        });
      }).catchError((_) {
        isLoading(false);
        isShowOtpTypeOption(false);
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
}
