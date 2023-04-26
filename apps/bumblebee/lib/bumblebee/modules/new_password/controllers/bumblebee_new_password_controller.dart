import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BumblebeeNewPasswordController extends GetxController {
  BumblebeeNewPasswordController({required this.authRepository});

  final AuthRepository authRepository;

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final emailController = TextEditingController();
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
    if (Get.arguments != null) {
      key.value = Get.arguments['key'];
      emailController.text = Get.arguments['email'];
      flag.value = Get.arguments['flag'];
    } else {
      key.value = Get.parameters['key']!;
      emailController.text = Get.parameters['email']!;
      flag.value = Get.parameters['flag']!;
    }
    
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
      return ContentConstant.badRequestLoginPasswordEmpty;
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
      showDialogMobile();
    }).catchError((onError) async {
      await AnalyticConfig().sendEventFailed(eventName);
      isLoading(false);
    });
  }

  showDialogMobile() {
    Get.defaultDialog(
        title: "",
        barrierDismissible: false,
        backgroundColor: DeasyColor.neutral000,
        content: Container(
          width: DeasySizeConfigUtils.screenWidth! / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'resources/images/checklist.svg',
              ),
              SizedBox(height: 24),
              Text(
                'Berhasil Mengatur Kata Sandi Baru',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: DeasyColor.neutral900,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Text('Silahkan login untuk masuk ke halaman utama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: DeasyColor.neutral400,
                    fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 24),
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: () async {
                  String completeEventName =
                      flag.value.isContainIgnoreCase('create')
                          ? "Register_Merchant_Complete"
                          : "Forgot_Password_Complete";
                  await AnalyticConfig().sendEvent(completeEventName);
                  Get.offAllNamed(BumblebeeRoutes.LOGIN);
                },
                child: Container(
                  decoration: new BoxDecoration(
                      color: DeasyColor.kpYellow500,
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0))),
                  width: DeasySizeConfigUtils.screenWidth! / 2,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(color: DeasyColor.neutral000),
                    ),
                  )),
                ),
              ),
              SizedBox(height: 16),
            ],
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
