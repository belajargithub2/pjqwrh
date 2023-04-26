import 'package:deasy_config/deasy_config.dart';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DeasyLogout {
  late DeasyPocket _deasyPocket;
  final userRepository = UserRepository();

  DeasyLogout() {
    _deasyPocket = DeasyPocket();
  }

  Future logout(
      {bool isExpired = false, Function? unsubscribeFromTopic}) async {
    String role = await _deasyPocket.getRole();
    if (unsubscribeFromTopic != null) {
      unsubscribeFromTopic();
      logoutApi(isExpired, role);
    } else {
      logoutApi(isExpired, role);
    }
  }

  clearLocalData(String role) {
    _deasyPocket.clear().then((success) {
      if (role.isContainIgnoreCase("agent")) {
        _deasyPocket.setBool("is_tutorial_passed_agent", true);
      } else if (role.isContainIgnoreCase('merchant')) {
        _deasyPocket.setBool("is_tutorial_passed_merchant", true);
      }
      if (kIsWeb) {
        Get.offAllNamed('/login');
      } else {
        Get.offAllNamed('/login/:key/:email/:flag');
      }
      
    });
  }

  logoutApi(bool isExpired, String role) async {
    bool? isHistoryLoginTracked =
        await _deasyPocket.getBool('is_history_login_tracked');
    if (isExpired) {
      clearLocalData(role);
    } else {
      String userId = await _deasyPocket.getUserId();
      if (isHistoryLoginTracked == true)
        await historyLogout();

      userRepository.logout(Get.context, {"user_id": userId}).whenComplete(() {
        AnalyticConfig().sendEvent("Profile_Logout");
        clearLocalData(role);
      });
    }
  }

  Future<void> historyLogout() async {
    String? email;
    String? phoneNumber;
    String? browserType;
    String? browserVersion;

    bool isLoginByEmail = await _deasyPocket.getIsLoginByEmail();

    if (isLoginByEmail) {
      email = await _deasyPocket.getEmail();
    } else {
      phoneNumber = await _deasyPocket.getPhoneNumber();
    }

    int loginHistoriesId = await _deasyPocket.getLoginHistoriesId();
    String? appsVersion = await _deasyPocket.getAppsVersion();
    String? deviceId = await _deasyPocket.getDeviceId();
    String? deviceModel = await _deasyPocket.getDeviceModel();
    bool isMobile = await _deasyPocket.getIsMobile();
    double? latitude = await _deasyPocket.getLatitude();
    double? longitude = await _deasyPocket.getLongitude();
    String? osVersion = await _deasyPocket.getOsVersion();

    if (!isMobile) {
      browserType = await _deasyPocket.getBrowserType();
      browserVersion = await _deasyPocket.getBrowserVersion();
    }

    userRepository.postApiHistoryLogout(Get.context,
        loginHistoriesId: loginHistoriesId,
        appsVersion: appsVersion,
        browserType: browserType,
        browserVersion: browserVersion,
        deviceId: deviceId,
        deviceModel: deviceModel,
        email: email,
        isMobile: isMobile,
        latitude: latitude,
        longitude: longitude,
        osVersion: osVersion,
        phoneNumber: phoneNumber);
  }
}
