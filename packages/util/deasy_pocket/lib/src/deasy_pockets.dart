import 'dart:convert';
import 'package:deasy_encryptor/deasy_encryptor.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class DeasyPocket {
  Future<SharedPreferences>? prefs;
  late SharedPreferences sharedPreferences;

  DeasyPocket() {
    prefs = SharedPreferences.getInstance();
  }

  Future<bool> clear() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.clear();
  }

  Future<bool?> getBool(String key) async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool(key) ?? false);
  }

  Future<bool> setBool(String key, bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(key, value);
  }

  Future<String> getFcmToken() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("fcm_token"));
  }

  Future<bool> setFcmToken(String value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setString("fcm_token", value);
  }

  Future<bool> isUserLoggedIn() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getString("access_token") != null);
  }

  Future<bool> isUserMerchant() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(DeasyEncryptorUtil.decryptString(
            sharedPreferences.getString("role")!) ==
        "merchant");
  }

  Future<String> getRole() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(
        DeasyEncryptorUtil.decryptString(sharedPreferences.getString("role")!));
  }

  Future<String> getToken() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(DeasyEncryptorUtil.decryptString(
        sharedPreferences.getString("access_token")!));
  }

  Future<void> setNewToken(String token) async {
    await sharedPreferences.setString(
        "access_token", DeasyEncryptorUtil.encryptString('$token'));
  }

  Future<bool> isMerchantOnline() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool("isMerchantOnline") ?? false);
  }

  Future<String> getSupplierIdOrAgentId() async {
    sharedPreferences = await prefs!;
    String role =
        DeasyEncryptorUtil.decryptString(sharedPreferences.getString("role")!);
    if (role == Constant.ROLE_AGENT) {
      return Future<String>.value(DeasyEncryptorUtil.decryptString(
          sharedPreferences.getString("agent_id")!));
    } else {
      return Future<String>.value(DeasyEncryptorUtil.decryptString(
          sharedPreferences.getString("supplier_id")!));
    }
  }

  Future<bool> isUserVerified() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool("isVerified"));
  }

  Future<String> getName() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(
        DeasyEncryptorUtil.decryptString(sharedPreferences.getString("name")!));
  }

  Future<String> getEmail() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(DeasyEncryptorUtil.decryptString(
        sharedPreferences.getString("email")!));
  }

  Future<String> getSupplierId() async {
    sharedPreferences = await prefs!;
    String? supplierId = sharedPreferences.getString("supplier_id");
    if (supplierId == null) {
      return '';
    } else {
      return Future<String>.value(DeasyEncryptorUtil.decryptString(
          sharedPreferences.getString("supplier_id")!));
    }
  }

  Future<String> getBranchId() async {
    sharedPreferences = await prefs!;
    String branchId =
        sharedPreferences.getString(KEY_PREFERENCES.merchantBranchId) ?? '';
    if (branchId.isEmpty) {
      return '';
    } else {
      return Future<String>.value(DeasyEncryptorUtil.decryptString(
          sharedPreferences.getString(KEY_PREFERENCES.merchantBranchId)!));
    }
  }

  Future<String> getRoleId() async {
    sharedPreferences = await prefs!;
    String roleId = sharedPreferences.getString(KEY_PREFERENCES.roleId)!;
    if (roleId.isEmpty) {
      return '';
    } else {
      return Future<String>.value(DeasyEncryptorUtil.decryptString(
          sharedPreferences.getString(KEY_PREFERENCES.roleId)!));
    }
  }

  Future<String> getRefreshToken() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(DeasyEncryptorUtil.decryptString(
        sharedPreferences.getString("refresh_token")!));
  }

  Future<String> getUserId() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(DeasyEncryptorUtil.decryptString(
        sharedPreferences.getString("user_id")!));
  }

  Future<bool> isUseSnb() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool("is_use_snb"));
  }

  Future<bool> tutorialPassedMerchant() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool("is_tutorial_passed_merchant") ?? false);
  }

  Future<bool> tutorialPassedAgent() async {
    sharedPreferences = await prefs!;
    return await Future<bool>.value(
        sharedPreferences.getBool("is_tutorial_passed_agent") ?? false);
  }

  Future<int> getLoginHistoriesId() async {
    sharedPreferences = await prefs!;
    return Future<int>.value(sharedPreferences.getInt("login_histories_id"));
  }

  Future<String> getPhoneNumber() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("phone_number"));
  }

  Future<String> getAppsVersion() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("apps_version"));
  }

  Future<String> getBrowserType() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("browser_type"));
  }

  Future<String> getBrowserVersion() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("browser_version"));
  }

  Future<String> getDeviceId() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("device_id"));
  }

  Future<String?> getDeviceModel() async {
    sharedPreferences = await prefs!;
    return Future<String?>.value(sharedPreferences.getString("device_model"));
  }

  Future<bool> getIsMobile() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool("is_mobile"));
  }

  Future<double?> getLatitude() async {
    sharedPreferences = await prefs!;
    return Future<double?>.value(sharedPreferences.getDouble("latitude"));
  }

  Future<double?> getLongitude() async {
    sharedPreferences = await prefs!;
    return Future<double?>.value(sharedPreferences.getDouble("longitude"));
  }

  Future<String> getOsVersion() async {
    sharedPreferences = await prefs!;
    return Future<String>.value(sharedPreferences.getString("os_version"));
  }

  Future<bool> getIsLoginByEmail() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool("is_login_by_email"));
  }

  Future<void> saveSupplierId(String supplierId) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setString(
        "supplier_id",
        supplierId.isEmpty
            ? supplierId
            : DeasyEncryptorUtil.encryptString(supplierId));
  }

  Future<void> saveSnbSettingResponse(
      {bool isShowDp = false,
      bool useSnb = false,
      bool isMaintenanceMode = false,
      int qrCodeTimer = 0,
      int retryGenerateQrCount = 0}) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setBool(KEY_PREFERENCES.isShowDp, isShowDp);
    sharedPreferences.setBool(KEY_PREFERENCES.useSnb, useSnb);
    sharedPreferences.setBool(
        KEY_PREFERENCES.isMaintenanceMode, isMaintenanceMode);
    sharedPreferences.setInt(KEY_PREFERENCES.qrCodeTimer, qrCodeTimer);
    sharedPreferences.setInt(
        KEY_PREFERENCES.retryGenerateQrCount, retryGenerateQrCount);
  }

  Future<int> getQrCodeTimer() async {
    sharedPreferences = await prefs!;
    return Future<int>.value(
        sharedPreferences.getInt(KEY_PREFERENCES.qrCodeTimer));
  }

  Future<int> getRetryGenerateQrCount() async {
    sharedPreferences = await prefs!;
    return Future<int>.value(
        sharedPreferences.getInt(KEY_PREFERENCES.retryGenerateQrCount));
  }

  Future<bool> getUseSnb() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.useSnb) ?? false);
  }

  Future<bool> getUseNewwg() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.useNewwg) ?? false);
  }

  Future<bool> getShowDp() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.isShowDp));
  }

  Future<bool> setDeleteAccountOnProcess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool("delete_account_on_process", value);
  }

  Future<bool> setOfflineAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.offline, value);
  }

  Future<bool> setSnbAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.snb, value);
  }

  Future<bool> setUseNewwg(bool? value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.useNewwg, value!);
  }

  Future<bool> setOnlineAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.online, value);
  }

  Future<bool> setPOAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.po, value);
  }

  Future<bool> setRequestCancel(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.requestCancel, value);
  }

  Future<bool> setInvoiceAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.invoice, value);
  }

  Future<bool> setViewBASTAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.viewBast, value);
  }

  Future<bool> setViewBuktiTerimaAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.viewBuktiTerima, value);
  }

  Future<bool> setViewImeiAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.viewImei, value);
  }

  Future<bool> setUploadBASTAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.uploadBast, value);
  }

  Future<bool> setUploadBuktiTerimaAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.uploadBuktiTerima, value);
  }

  Future<bool> setUploadImeiAccess(bool value) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setBool(KEY_PREFERENCES.uploadImei, value);
  }

  Future<bool> getOfflineAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.offline));
  }

  Future<bool> getSnbAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool(KEY_PREFERENCES.snb));
  }

  Future<bool> getOnlineAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.online));
  }

  Future<bool> getPOAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(sharedPreferences.getBool(KEY_PREFERENCES.po));
  }

  Future<bool> getRequestCancel() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.requestCancel));
  }

  Future<bool> getInvoiceAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.invoice));
  }

  Future<bool> getViewBASTAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.viewBast));
  }

  Future<bool> getViewBuktiTerimaAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.viewBuktiTerima));
  }

  Future<bool> getViewImeiAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.viewImei));
  }

  Future<bool> getUploadBASTAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.uploadBast));
  }

  Future<bool> getUploadBuktiTerimaAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.uploadBuktiTerima));
  }

  Future<bool> getUploadImeiAccess() async {
    sharedPreferences = await prefs!;
    return Future<bool>.value(
        sharedPreferences.getBool(KEY_PREFERENCES.uploadImei));
  }

  Future<bool> setRoleMenuPermission(
      Map<String, dynamic> menuPermission) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setString(
        KEY_PREFERENCES.roleMenuPermission, jsonEncode(menuPermission));
  }

  Future<bool> setRoleDashboardPermission(
      Map<String, dynamic> dashboardPermission) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setString(KEY_PREFERENCES.roleDashboardPermission,
        jsonEncode(dashboardPermission));
  }

  Future<bool> setRoleDetail(Map<String, dynamic> roleData) async {
    sharedPreferences = await prefs!;
    return sharedPreferences.setString(
        KEY_PREFERENCES.roleDetail, jsonEncode(roleData));
  }

  Future<Map<String, dynamic>> getRoleDetail() async {
    sharedPreferences = await prefs!;

    Map<String, dynamic> roleMap = {};
    final String? roleStr =
        sharedPreferences.getString(KEY_PREFERENCES.roleDetail);
    if (roleStr != null) {
      roleMap = jsonDecode(roleStr) as Map<String, dynamic>;
    }
    return roleMap;
  }

  Future<Map<String, dynamic>> getRoleDashboardPermission() async {
    sharedPreferences = await prefs!;

    Map<String, dynamic> dashboardPermissionMap = {};
    final String? dashboardPermissionStr =
        sharedPreferences.getString(KEY_PREFERENCES.roleDashboardPermission);
    if (dashboardPermissionStr != null) {
      dashboardPermissionMap =
          jsonDecode(dashboardPermissionStr) as Map<String, dynamic>;
    }
    return dashboardPermissionMap;
  }

  Future<Map<String, dynamic>> getMenuPermission() async {
    sharedPreferences = await prefs!;

    Map<String, dynamic> menuPermissionMap = {};
    final String? menuPermissionStr =
        sharedPreferences.getString(KEY_PREFERENCES.roleMenuPermission);
    if (menuPermissionStr != null) {
      menuPermissionMap = jsonDecode(menuPermissionStr) as Map<String, dynamic>;
    }
    return menuPermissionMap;
  }

  Future<bool?> getIsDealerSubsidies() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.getBool(KEY_PREFERENCES.isDealerSubsidies);
  }

  Future<int?> getOtpTimer() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.getInt(KEY_PREFERENCES.otpTimer);
  }

  Future<void> setOtpTimer(int time) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setInt(KEY_PREFERENCES.otpTimer, time);
  }

  Future<void> removeOtpTimer() async {
    sharedPreferences = await prefs!;
    sharedPreferences.remove(KEY_PREFERENCES.otpTimer);
  }

  Future<void> setNewWgAuthConfigs(Map<String, dynamic> config) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setString(
        KEY_PREFERENCES.newWgAuthConfigs, jsonEncode(config));
  }

  Future<Map<String, dynamic>?> getNewWgAuthConfig() async {
    sharedPreferences = await prefs!;
    Map<String, dynamic> result = {};

    final String? stringResponse =
        sharedPreferences.getString(KEY_PREFERENCES.newWgAuthConfigs);
    if (stringResponse != null) {
      result = jsonDecode(stringResponse) as Map<String, dynamic>;
      return result;
    }
    return null;
  }

  Future<void> setNewWgDataConfigs(Map<String, dynamic> config) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setString(
        KEY_PREFERENCES.newWgDataConfigs, jsonEncode(config));
  }

  Future<Map<String, dynamic>?> getNewWgDataConfig() async {
    sharedPreferences = await prefs!;
    Map<String, dynamic> result = {};

    final String? stringResponse =
        sharedPreferences.getString(KEY_PREFERENCES.newWgDataConfigs);
    if (stringResponse != null) {
      result = jsonDecode(stringResponse) as Map<String, dynamic>;
      return result;
    }
    return null;
  }

  Future<void> setProspectId(String prospectId) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setString(KEY_PREFERENCES.prospectIdNewWg, prospectId);
  }

  Future<String?> getProspectId() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.getString(KEY_PREFERENCES.prospectIdNewWg);
  }

  Future<int?> getResendEmailCount() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.getInt(KEY_PREFERENCES.resendEmailCount);
  }

  Future<void> setResendEmailCount(int resendEmailCount) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setInt(
        KEY_PREFERENCES.resendEmailCount, resendEmailCount);
  }

  Future<void> removeResendEmailCount() async {
    sharedPreferences = await prefs!;
    sharedPreferences.remove(KEY_PREFERENCES.resendEmailCount);
  }

  Future<String?> getResendEmailRetryAt() async {
    sharedPreferences = await prefs!;
    return sharedPreferences.getString(KEY_PREFERENCES.resendEmailRetryAt);
  }

  Future<void> setResendEmailRetryAt(String resendEmailRetryAt) async {
    sharedPreferences = await prefs!;
    sharedPreferences.setString(
        KEY_PREFERENCES.resendEmailRetryAt, resendEmailRetryAt);
  }

  Future<void> removeResendEmailRetryAt() async {
    sharedPreferences = await prefs!;
    sharedPreferences.remove(KEY_PREFERENCES.resendEmailRetryAt);
  }

  setInitialRetryAtAndCount() async {
    await DeasyPocket().setResendEmailRetryAt(
        (DateTime.now().add(Duration(minutes: 5)).toString()));

    await DeasyPocket().setResendEmailCount(1);
  }
}
