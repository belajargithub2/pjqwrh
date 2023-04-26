import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryMock with Mock implements AuthRepository {
  @override
  Future<GetTokenResponse> getTokenEmail(
      BuildContext? context, Map<String, dynamic>? requestBody) {
    return Future.value(GetTokenResponse(
        data: GetTokenData(token: "fk9cm52Nr3EQMseY7"), message: "OK"));
  }

  @override
  Future<PasswordMailResponse> postPasswordEmail(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) {
    return Future.value(PasswordMailResponse(message: "OK"));
  }
}
