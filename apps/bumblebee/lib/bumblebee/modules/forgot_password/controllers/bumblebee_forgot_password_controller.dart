import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BumblebeeForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final authRepository = Get.find<AuthRepository>();
  final deepLinkRepository = Get.find<DeepLinkRepository>();
  final dynamicLinkConfig = Get.find<DynamicLinkConfig>();
  final analyticConfig = Get.find<AnalyticConfig>();

  final email = ''.obs;
  final versionApp = ''.obs;
  final isShowDialogMobile = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    DeasySizeConfigUtils().init(context: Get.context);
    getVersion();
    super.onInit();
  }

  Future<void> submit(BuildContext? context, String email) async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        String? token = await getToken();
        String urlResponse = await createDynamicLink(token);
        PasswordMailResponse? sendEmailResponse =
            await sendEmail(Uri.parse(urlResponse), token);
        successSendEmail(sendEmailResponse);
      } catch (_) {}
      isLoading.value = false;
    }
  }

  Future<String?> getToken() async {
    GetTokenResponse tokenResponse =
        await authRepository.getTokenEmail(Get.context, null);
    return tokenResponse.data!.token;
  }

  Future<String> createDynamicLink(String? token) async {
    final url = await dynamicLinkConfig.createDynamicLink(
        token, deepLinkRepository, email.value, "reset", 'new-password');
    return url;
  }

  Future<PasswordMailResponse?> sendEmail(Uri url, String? token) async {
    var passwordMailResponse;

    await authRepository
        .postPasswordEmail(Get.context, createRequestPasswordMail(url, token),
            "F_Pass_Verify_Email")
        .then((value) {
      analyticConfig.sendEventSuccess("F_Pass_Verify_Email");
      passwordMailResponse = value;
    }).catchError((_) {
      analyticConfig.sendEventFailed("F_Pass_Verify_Email");
    });
    isLoading.value = false;

    return passwordMailResponse;
  }

  Map<String, dynamic> createRequestPasswordMail(Uri url, String? token) {
    var request = Map<String, String>();
    request["email"] = email.value;
    request["type"] = "reset_password";
    request["url"] = "$url";
    request["token"] = "$token";
    return request;
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionApp.value = packageInfo.version;
    return versionApp.value;
  }

  void successSendEmail(PasswordMailResponse? sendEmailResponse) {
    if (sendEmailResponse != null) {
      isShowDialogMobile(true);
    }
  }

  void setEmailValue(String text) {
    email.value = text;
  }

  String? validateEmail(String text) {
    if (text.isEmpty) {
      return ContentConstant.badRequestLoginPasswordEmpty;
    }
    if (!text.isEmailAddress()) {
      return ContentConstant.emailNotValid;
    }
    return null;
  }
}
