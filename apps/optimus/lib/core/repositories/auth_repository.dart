

import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/check_email/check_email.dart';
import 'package:kreditplus_deasy_website/core/model/user/get_token_response.dart';
import 'package:kreditplus_deasy_website/core/model/user/merchant_type_response_model.dart';
import 'package:kreditplus_deasy_website/core/model/user/user_password_mail.dart';
import 'package:kreditplus_deasy_website/core/model/user/user_refresh_token.dart';
import 'package:kreditplus_deasy_website/core/model/user/user_reset_password.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class AuthRepository {
  DioClient _provider = DioClient();


  Future<ResetPasswordResponse> postResetPassword(
      BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(
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
    DioClient _providerWithEvent = DioClient(
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