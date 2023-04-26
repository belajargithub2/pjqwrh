import 'dart:async';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeeSplashScreenController extends GetxController {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final versionApp = ''.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void init() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  versionApp.value = packageInfo.version;
    Timer(
        Duration(seconds: 5),
        () => {
              isUserLoggedIn().then((isUserLoggedIn) {
                if (isUserLoggedIn) {
                  Get.offAndToNamed(Routes.HOME_CONTAINER);
                } else {
                  isFirstLaunch().then((isFirstLaunch) {
                    if (isFirstLaunch) {
                      Get.offAndToNamed(Routes.ON_BOARDING);
                    } else {
                      Get.offAndToNamed(BumblebeeRoutes.LOGIN);
                    }
                  });
                }
              })
            });
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences sharedPreferences = await _prefs;
    return Future<bool>.value(
        sharedPreferences.getString("access_token") != null);
  }

  Future<bool> isFirstLaunch() async {
    final SharedPreferences sharedPreferences = await _prefs;
    return Future<bool>.value(
        sharedPreferences.getBool("is_first_launch") == null ? true : false);
  }
}
