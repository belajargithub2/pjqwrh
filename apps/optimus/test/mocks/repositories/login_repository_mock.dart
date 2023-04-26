import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_histories_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/request_otp_response.dart'
    as ror;
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';

class LoginRepositoryMock implements OptimusLoginRepository {
  @override
  Future<OptimusLoginResponse> postApiLoginUseEmail(
    BuildContext? context, {
    required String? deviceId,
    required String email,
    required String password,
    String? eventName,
  }) {
    return Future.value(
      OptimusLoginResponse(
        code: 0,
        message: 'a',
        data: LoginData(
          id: 'a',
          supplierId: 'a',
          name: 'a',
          email: 'email',
          isMerchantOnline: true,
          isVerified: true,
          role: 'a',
          roleId: 'a',
          accessToken: '',
          refreshToken: '',
          expire: 1,
          deviceId: 'deviceId',
          lastLoginDate: DateTime(2021),
          code: 's',
          message: 's',
        ),
      ),
    );
  }

  @override
  Future<ror.ResponseRequestOtp> requestOTP(BuildContext? context,
      Map<String, dynamic> requestBody, bool showSnackbar) {
    return Future.value(
      ror.ResponseRequestOtp(
        message: "OK",
        data: ror.Data(
          phoneNumber: '0987654312',
          retryAt: 1,
        ),
      ),
    );
  }

  @override
  Future<OptimusLoginResponse> postApiLoginUsePhoneNumber(
    BuildContext context, {
    String? otsCode,
    String? phoneNumber,
    String? deviceId,
    String? eventName,
  }) {
    return Future.value(
      OptimusLoginResponse(
        code: 0,
        message: 'a',
        data: LoginData(
          id: 'a',
          supplierId: 'a',
          name: 'a',
          email: 'a',
          isMerchantOnline: true,
          isVerified: true,
          role: 'a',
          roleId: 'a',
          accessToken: '',
          refreshToken: '',
          expire: 1,
          deviceId: 's',
          lastLoginDate: DateTime(2021),
          code: 's',
          message: 's',
        ),
      ),
    );
  }

  @override
  Future<OptimusHistoriesLoginResponse> postApiHistoryLogin(
    BuildContext? context, {
    String? appsVersion,
    String? browserType,
    String? browserVersion,
    String? deviceId,
    String? deviceModel,
    String? email,
    bool? isMobile,
    double? latitude,
    double? longitude,
    String? osVersion,
    String? phoneNumber,
  }) {
    // TODO: implement postApiHistoryLogin
    throw UnimplementedError();
  }
}
