import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/user/get_token_response.dart'
    as getToken;
import 'package:kreditplus_deasy_website/core/model/user/user_password_mail.dart';
import 'package:kreditplus_deasy_website/core/repositories/auth_repository.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryMock with Mock implements AuthRepository {
  @override
  Future<getToken.GetTokenResponse> getTokenEmail(
      BuildContext? context, Map<String, dynamic>? requestBody) {
    return Future.value(getToken.GetTokenResponse(
        data: getToken.Data(token: "fk9cm52Nr3EQMseY7"), message: "OK"));
  }

  @override
  Future<PasswordMailResponse> postPasswordEmail(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) {
    return Future.value(PasswordMailResponse(message: "OK"));
  }
}
