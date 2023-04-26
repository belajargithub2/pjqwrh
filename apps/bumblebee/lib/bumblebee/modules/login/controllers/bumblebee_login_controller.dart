import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/request/user_fcm_request.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/core/config/crashlytic_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/fcm_config.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/dialogs/dialog_content_one_button_widget.dart';
import 'package:newwg/config/auth_config.dart';
import 'package:newwg/config/data_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeeLoginController extends GetxController
    with SingleGetTickerProviderMixin {
  FirebaseMessaging? _messaging;
  final appVersion = ''.obs;
  String? deviceId;
  String? deviceModel;
  String? deviceOs;
  String? browserType;
  String? browserVersion;
  TabController? tabController;
  RxBool showForgotPassword = false.obs;
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();
  final Rx<DeasyDeviceInfo> device = Get.find<DeasyDeviceInfo>().obs;
  BumblebeeSnapNBuyRepository _snapNBuyRepository;
  UserRepository _userRepository;
  final RxString _flagDeleteAccount = ''.obs;
  String? _userIdFromDeeplink;
  final String _contentTitleDialog = 'Penghapusan Akun Ditunda';
  final String _contentBtn = 'Oke';

  BumblebeeLoginController(
      {BumblebeeSnapNBuyRepository? snapNBuyRepository,
      UserRepository? userRepository})
      : _snapNBuyRepository = snapNBuyRepository!,
        _userRepository = userRepository!;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);

    if (io.Platform.isIOS) {
      checkAppTrackingTransparency();
    }

    if (_messaging == null) {
      _messaging = FirebaseMessaging.instance;
    }
    super.onInit();
  }

  @override
  void onReady() async {
    getDeviceId();
    getDeviceOs();
    getDeviceModel();
    getAppVersion();
    super.onReady();
  }

  Future checkDeleteAccountDynamicLink() async {
    await retrieveDeepLink();
    checkDeleteAccountStatus();
  }

  Future<void> checkAppTrackingTransparency() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  void getToken(BuildContext context) {
    _messaging!
        .getToken(vapidKey: flavorConfiguration!.vapidKey)
        .then((value) => DeasyPocket().setFcmToken(value!));
  }

  Future getAppVersion() async {
    await PackageInfo.fromPlatform().then((value) {
      appVersion.value = value.version;
    });
  }

  String? sendLoginTabEvent(int index) {
    String? loginType;
    if (index == 0) {
      AnalyticConfig().sendEvent("Login_Email");
      loginType = "Login_Email";
    } else if (index == 1) {
      AnalyticConfig().sendEvent("Login_Phone");
      loginType = "Login_Phone";
    }

    return loginType;
  }

  Future<void> saveDataToLocalAfterDoLogin(
      {required LoginData response, required bool isLoginByEmail}) async {
    SharedPreferences sharedPreferences = await sharedPreference;
    await sharedPreferences.setBool("is_login_by_email", isLoginByEmail);

    if (response.accessToken != null)
      await sharedPreferences.setString("access_token",
          DeasyEncryptorUtil.encryptString(response.accessToken!));

    if (response.refreshToken != null)
      await sharedPreferences.setString("refresh_token",
          DeasyEncryptorUtil.encryptString(response.refreshToken!));

    if (response.name != null)
      await sharedPreferences.setString(
          "name", DeasyEncryptorUtil.encryptString(response.name!));

    if (response.roleId != null)
      await sharedPreferences.setString(KEY_PREFERENCES.roleId,
          DeasyEncryptorUtil.encryptString(response.roleId!));

    if (response.email != null)
      await sharedPreferences.setString(
          "email", DeasyEncryptorUtil.encryptString(response.email!));

    if (response.id != null)
      await sharedPreferences.setString(
          "user_id", DeasyEncryptorUtil.encryptString(response.id!));

    if (response.role != null)
      await sharedPreferences.setString(
          "role", DeasyEncryptorUtil.encryptString(response.role!));

    if (response.isVerified != null)
      await sharedPreferences.setBool("isVerified", response.isVerified!);

    if (response.isMerchantOnline != null)
      await sharedPreferences.setBool(
          "isMerchantOnline", response.isMerchantOnline!);

    if (response.isShowMenuSubsidiDealer != null)
      await sharedPreferences.setBool(
          KEY_PREFERENCES.isDealerSubsidies, response.isShowMenuSubsidiDealer!);

    if (response.agentId != null)
      await sharedPreferences.setString("agent_id",
          DeasyEncryptorUtil.encryptString(response.agentId.toString()));

    if (response.nik != null)
      await sharedPreferences.setString(
          "nik", DeasyEncryptorUtil.encryptString(response.nik!));

    if (response.userType != null)
      await sharedPreferences.setString(
          "user_type", DeasyEncryptorUtil.encryptString(response.userType!));

    if (response.merchantBranchId!.isNotNullAndNotEmpty)
      await sharedPreferences.setString(
          KEY_PREFERENCES.merchantBranchId,
          DeasyEncryptorUtil.encryptString(
              response.merchantBranchId.toString()));

    if (response.supplierId != null && response.supplierId!.isNotEmpty) {
      await sharedPreferences.setString("supplier_id",
          DeasyEncryptorUtil.encryptString(response.supplierId.toString()));
    }

    if (response.merchantBranchId!.isNotNullAndNotEmpty &&
        response.supplierId!.isNotNullAndNotEmpty) {
      await _snapNBuyRepository
          .fetchApiSnapNBuySettings(
              Get.context, response.supplierId, response.merchantBranchId)
          .then((response) => response.data!.toSharedPref())
          .catchError((error) {
        DeasySnackBarUtil.showFlushBarError(Get.context!, "$error");
      });
    }

    await sharedPreferences.setString("app_version", appVersion.value);
    await sharedPreferences.setString("device_id", deviceId!);
    await sharedPreferences.setString("device_os", deviceOs!);
    await sharedPreferences.setString("device_model", deviceModel!);

    if (response.role!.toLowerCase() != "super admin") {
      updateFCMToken(response);
    }

    firebaseInit(response.supplierId.toString());
  }

  void firebaseInit(String supplierId) {
    fcmSubscribe(supplierId);
    CrashLyticConfig().setKeyUser(supplierId);
  }

  void updateFCMToken(LoginData value) {
    DeasyPocket().getFcmToken().then((token) async {
      UserFcmRequest _request = UserFcmRequest();
      _request.supplierId = value.supplierId.toString();
      _request.token = token.isNotEmpty ? token : "";
      _request.userId = value.id;
      await _userRepository.updateFcmUser(Get.context, _request.toJson());
    });
  }

  Future getDeviceId() async {
    device.value.getDeviceId().then((value) {
      deviceId = value;
    });
  }

  Future getDeviceModel() async {
    device.value.getDeviceModel().then((value) {
      deviceModel = value;
    });
  }

  Future getDeviceOs() async {
    device.value.getDeviceOs().then((value) {
      deviceOs = value;
    });
  }

  getBrowserType() async {
    device.value.getBrowserType().then((value) {
      browserType = value;
    });
  }

  getBrowserVersion() async {
    device.value.getBrowserVersion().then((value) {
      browserVersion = value;
    });
  }

  navigateToHome() {
    Get.offAndToNamed(Routes.HOME_CONTAINER);
  }

  bool checkRoleForMobile(LoginResponse value) {
    if (value.data!.role!.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) ||
        value.data!.role!.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      return true;
    } else {
      return false;
    }
  }

  void checkDeleteAccountStatus() {
    if (_flagDeleteAccount.value == ContentConstant.flagAccountDeleted) {
      deleteMyAccount();
    }
  }

  Future<void> deleteMyAccount() async {
    _userRepository
        .deleteAccount(Get.context, null, _userIdFromDeeplink)
        .then((value) => value.data != null
            ? _showDialogDeleteAccountFailed(value.data!.message)
            : _showDialogDeleteAccountSuccess())
        .catchError((onError) {
      _showDialogDeleteAccountFailed(onError.toString());
    });
  }

  Future retrieveDeepLink() async {
    _flagDeleteAccount.value =
        Get.parameters == null ? '' : Get.parameters['flag']!;
    _userIdFromDeeplink = Get.parameters == null ? '' : Get.parameters['email'];
  }

  void _showDialogDeleteAccountSuccess() {
    Get.defaultDialog(
      onWillPop: () async => false,
      title: ContentConstant.noString,
      backgroundColor: DeasyColor.neutral000,
      content: DialogContentOneButtonWidget(
        icon: IconConstant.RESOURCES_ICON_SUCCESS_PATH,
        contentTitle: DialogConstant.dialogDeleteAccountSuccessTitle,
        contentSubTitle: DialogConstant.dialogDeleteAccountSuccessSubTitle,
        buttonText: DialogConstant.dialogBtnOke,
        btnPress: () async {
          await DeasyPocket().setDeleteAccountOnProcess(false);
          Get.back();
        },
      ),
    );
  }

  void _showDialogDeleteAccountFailed(String? contentSubtitle) {
    Get.defaultDialog(
      title: ContentConstant.noString,
      backgroundColor: DeasyColor.neutral000,
      content: DialogContentOneButtonWidget(
        icon: IconConstant.RESOURCES_ICON_WARNING_PATH,
        contentTitle: _contentTitleDialog,
        contentSubTitle: contentSubtitle,
        buttonText: _contentBtn,
        btnPress: () => Get.back(),
      ),
    );
  }

  Future<void> setToModule(LoginResponse response) async {
    final dataConfig = {
      "cro_id": response.data?.croId,
      "cro_name": response.data?.croName,
      "supplier_id": response.data?.supplierId,
      "supplier_name": response.data?.supplierName,
      "supplier_address": response.data?.supplierAddress,
      "supplier_key": "",
      "branch_id": response.data?.merchantBranchId,
      "is_new_wg": response.data?.isNewWg,
    };

    final authConfig = {
      "prefix": AuthConfig.instance.prefix,
      "x_source_token": response.data?.accessToken,
      "unique_id": int.parse("${10}${response.data?.merchantBranchId}")
    };

    DataConfig.instance.fromJson(dataConfig);
    AuthConfig.instance.fromJson(authConfig);

    await DeasyPocket().setUseNewwg(response.data?.isNewWg);
    await DeasyPocket().setNewWgDataConfigs(dataConfig);
    await DeasyPocket().setNewWgAuthConfigs(authConfig);
  }
}
