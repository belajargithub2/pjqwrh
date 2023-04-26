import 'dart:io' show Platform;
import 'package:deasy_helper/deasy_helper.dart';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/histories_login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeePermissionLocationController extends GetxController
    with WidgetsBindingObserver {
  double? latitude;
  double? longitude;
  final role = ''.obs;
  int limitCheckPermission = 0;
  final _loginRepository = Get.find<BumblebeeLoginRepository>();
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    role.value = await DeasyPocket().getRole();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      return;
    }

    if (Get.currentRoute == Routes.LIST_UPLOAD) {
      return;
    }

    if (state == AppLifecycleState.paused) {
      limitCheckPermission = 0;
    }

    if (state == AppLifecycleState.resumed) {
      if (limitCheckPermission < 2) {
        await checkPermission();
      }
    }

    if (limitCheckPermission < 2 && state == AppLifecycleState.paused) {
      getLocation();
    }
    super.didChangeAppLifecycleState(state);
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      checkAppTrackingTransparency();
    }
  }

  Future getDeviceLocation(Position position) async {
    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showRequestGpsDialog(true);
      return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      showRequestGpsDialog(false);

      return Future.error('Location permissions are denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  showRequestGpsDialog(bool locationIsEnabled) async {
    String titleErrorMessage;
    String detailErrorMessage;

    if (locationIsEnabled) {
      titleErrorMessage = ContentConstant.locationNotFound;
      detailErrorMessage = ContentConstant.needLocationPermission;
    } else {
      titleErrorMessage = ContentConstant.needLocationFeature;
      detailErrorMessage = ContentConstant.needLocationPermissionInSetting;
    }

    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                title: Text(titleErrorMessage),
                content: Text(detailErrorMessage),
                actions: <Widget>[
                  TextButton(
                      child: Text('OK'),
                      onPressed: () async {
                        Navigator.pop(context);
                        await Geolocator.openLocationSettings()
                            .then((value) => limitCheckPermission++);
                      }),
                  TextButton(
                      child: Text('Later'),
                      onPressed: () async {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
  }

  Future<bool> getLocation() async {
    latitude = null;
    longitude = null;
    bool isLocationGathered = false;

    await determinePosition().then((position) async {
      getDeviceLocation(position);
      if (Platform.isIOS) {
        checkAppTrackingTransparency();
      }
    }).whenComplete(() {
      if (latitude != null && longitude != null) {
        isLocationGathered = true;
      } else {
        isLocationGathered = false;
      }
    });

    return isLocationGathered;
  }

  Future<void> checkAppTrackingTransparency() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> postApiHistoryLogin() async {
    SharedPreferences sharedPreferences = await sharedPreference;

    String email = await DeasyPocket().getEmail();

    String? deviceId = sharedPreferences.getString("device_id");
    String? deviceModel = sharedPreferences.getString("device_model");
    String? deviceOs = sharedPreferences.getString("device_os");
    String appVersion = sharedPreferences.getString("app_version")!;
    String? browserType = sharedPreferences.getString("browser_type");
    String? browserVersion = sharedPreferences.getString("browser_version");

    return _loginRepository
        .postApiHistoryLogin(Get.context,
            appsVersion: appVersion,
            browserType: browserType,
            browserVersion: browserVersion,
            deviceId: deviceId,
            deviceModel: deviceModel,
            email: email,
            isMobile: true,
            latitude: latitude,
            longitude: longitude,
            osVersion: deviceOs)
        .then((responseHistoryLogin) {
      saveDataToLocalAfterPostHistoryLogin(responseHistoryLogin);
    });
  }

  void saveDataToLocalAfterPostHistoryLogin(
      HistoriesLoginResponse response) async {
    SharedPreferences sharedPreferences = await sharedPreference;
    if (response.data!.id != null)
      await sharedPreferences.setInt("login_histories_id", response.data!.id!);
    if (response.data!.appsVersion != null)
      await sharedPreferences.setString(
          "apps_version", response.data!.appsVersion!);
    if (response.data!.deviceId != null)
      await sharedPreferences.setString("device_id", response.data!.deviceId!);
    if (response.data!.deviceModel != null)
      await sharedPreferences.setString(
          "device_model", response.data!.deviceModel!);
    if (response.data!.isMobile != null)
      await sharedPreferences.setBool("is_mobile", response.data!.isMobile!);
    if (response.data!.latitude != null)
      await sharedPreferences.setDouble("latitude", response.data!.latitude!);
    if (response.data!.longitude != null)
      await sharedPreferences.setDouble("longitude", response.data!.longitude!);
    if (response.data!.osVersion != null)
      await sharedPreferences.setString(
          "os_version", response.data!.osVersion!);
    if (response.data!.browserType != null)
      await sharedPreferences.setString(
          "browser_type", response.data!.browserType!);
    if (response.data!.browserVersion != null)
      await sharedPreferences.setString(
          "browser_version", response.data!.browserVersion!);

    await sharedPreferences.setBool("is_history_login_tracked", true);
  }
}
