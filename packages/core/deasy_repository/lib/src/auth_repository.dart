

import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);


  Future<ResetPasswordResponse> postResetPassword(
      BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(isActiveRefreshTokenInterceptor: true,
      eventName: eventName,
      params: requestBody
    );

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "auth/password/change", requestBody, showSnackbar: true);
    return ResetPasswordResponse.fromJson(response);
  }

  Future<UserRefreshToken> refreshToken(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "auth/refresh-token", requestBody,isRegister: true,isRefreshToken:true);
    return UserRefreshToken.fromJson(response);
  }

  Future<GetTokenResponse> getTokenEmail(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "auth/password/email/token", requestBody);
    return GetTokenResponse.fromJson(response);
  }

  Future<PasswordMailResponse> postPasswordEmail(
      BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(isActiveRefreshTokenInterceptor: true,
      eventName: eventName,
      params: requestBody
    );

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "auth/password/email", requestBody, showSnackbar: true);
    return PasswordMailResponse.fromJson(response);
  }

  Future<ResponseCheckEmail> postCheckEmail(
      BuildContext context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "auth/check-email", requestBody);
    return ResponseCheckEmail.fromJson(response);
  }

  Future<MerchantTypeResponseModel> getMerchantTypes(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "auth/merchant-type", requestBody);
    return MerchantTypeResponseModel.fromJson(response);
  }

}