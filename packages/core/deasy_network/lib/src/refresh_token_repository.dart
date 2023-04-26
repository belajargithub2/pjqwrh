

import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/src/network_enum.dart';
import 'package:deasy_network/src/network_with_dio.dart';
import 'package:flutter/material.dart';

class RefreshTokenRepository {
  DioClient _provider = DioClient();

  Future<UserRefreshToken> refreshToken(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "auth/refresh-token", requestBody,isRegister: true,isRefreshToken:true);
    return UserRefreshToken.fromJson(response);
  }
}