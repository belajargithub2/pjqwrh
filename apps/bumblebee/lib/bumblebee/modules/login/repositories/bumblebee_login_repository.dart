import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/histories_login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/login_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/models/response/request_otp_response.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class BumblebeeLoginRepository {
  DioClient _provider = DioClient();

  Future<LoginResponse> postApiLoginUseEmail(BuildContext? context,
      {required String? deviceId,
      required String email,
      required String password,
      String? eventName}) async {
    var requestBody = <String, dynamic>{
      "device_id": deviceId,
      "email": email,
      "password": password
    };

    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "auth/login", requestBody,
        showSnackbar: true);
    return LoginResponse.fromJson(response);
  }

  Future<LoginResponse> postApiLoginUsePhoneNumber(BuildContext context,
      {required String otsCode,
      required String phoneNumber,
      required String? deviceId,
      String? eventName}) async {
    var requestBody = <String, dynamic>{
      "otp_code": otsCode,
      "phone_number": phoneNumber,
      "device_id": deviceId
    };

    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "auth/login", requestBody,
        showSnackbar: true);
    return LoginResponse.fromJson(response);
  }

  Future<ResponseRequestOtp> requestOTP(BuildContext? context,
      Map<String, dynamic> requestBody, bool showSnackbar) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "auth/request-otp", requestBody,
        showSnackbar: showSnackbar, isReturnError: true);
    return ResponseRequestOtp.fromJson(response);
  }

  Future<HistoriesLoginResponse> postApiHistoryLogin(BuildContext? context,
      {required String appsVersion,
      String? browserType,
      String? browserVersion,
      String? deviceId,
      String? deviceModel,
      required String email,
      bool? isMobile,
      double? latitude,
      double? longitude,
      String? osVersion,
      String? phoneNumber}) async {
    var requestBody = <String, dynamic>{
      "apps_version": appsVersion.toEmptyIfNull(),
      "browser_type": browserType ?? "",
      "browser_version": browserVersion ?? "",
      "device_id": deviceId ?? "",
      "device_model": deviceModel ?? "",
      "email": email.toEmptyIfNull(),
      "is_mobile": isMobile,
      "latitude": latitude,
      "longitude": longitude,
      "os_version": osVersion ?? "",
      "phone_number": phoneNumber ?? "",
    };

    final response = await _provider.post(
        context, Scope.MERCHANT, "histories/login", requestBody);

    return HistoriesLoginResponse.fromJson(response);
  }
}
