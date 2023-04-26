import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/widgets/register_dialog.dart';
import 'package:deasy_config/deasy_config.dart';

import '../../../../core/config/deep_link_config.dart';

class BumblebeeRegisterAgentController extends GetxController {
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;
  final UserRepository _userRepository;
  final registerDialog = Get.find<RegisterDialog>();

  BumblebeeRegisterAgentController({required UserRepository userRepository})
      : _userRepository = userRepository;

  final agentNameController = TextEditingController();
  final agentKTPController = TextEditingController();
  final agentEmailController = TextEditingController();
  final agentPhoneController = TextEditingController();
  final agentTypeController = TextEditingController();
  final authRepository = Get.find<AuthRepository>();
  final dynamicLinkConfig = Get.find<DynamicLinkConfig>();
  final deepLinkRepository = Get.find<DeepLinkRepository>();

  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  static const String userType = "KMOB";
  static const bool isAgent = true;

  UserRegisterAgentRequest _request(String url, String token) {
    return UserRegisterAgentRequest(
        name: agentNameController.text,
        phoneNumber: agentPhoneController.text,
        email: agentEmailController.text,
        userType: userType,
        nik: agentKTPController.text,
        isAgent: isAgent,
        createPasswordUrl: url,
        token: token);
  }

  Future<String> createDynamicLink(String? token) async {
    var url = await dynamicLinkConfig.createDynamicLink(
        token,
        deepLinkRepository,
        agentEmailController.text,
        "create",
        'new-password');
    return url;
  }

  Future<String> generatePasswordURL(String token) async {
    var url = await createDynamicLink(token);
    return url;
  }

  Future<String> getToken() async {
    var tokenResponse = await authRepository.getTokenEmail(Get.context, null);
    return tokenResponse.data!.token!;
  }

  Future<void> register() async {
    autoValidate.value = AutovalidateMode.always;
    if (formKey.currentState!.validate()) {
      isLoading.toggle();
      String token = await getToken();
      String url = await generatePasswordURL(token);
      
      _userRepository
          .userRegister(
              Get.context, _request(url, token).toJson(), "Register_Agent")
          .then((value) {
        if (value.code == 200) {
          registerDialog.mobileDefaultDialog();
          AnalyticConfig().sendEventSuccess("Register_Agent");
        }
      }).catchError((onError) {
        isLoading.toggle();
        AnalyticConfig().sendEventFailed("Register_Agent");
      });
    }
  }
}
