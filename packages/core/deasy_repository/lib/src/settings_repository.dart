import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<SettingsResponse> getAppVersion(
      BuildContext? context, String platform) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, 'settings/mobile/$platform', null);
    return SettingsResponse.fromJson(response);
  }

  Future<WordsResponseModel> getWords(
      BuildContext? context, String keyword) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, 'settings/wording/$keyword', null);
    return WordsResponseModel.fromJson(response);
  }
}
