import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class DeepLinkRepository {

  Future<DeepLinkResponse?> createLink(BuildContext? context,
    Map<String, dynamic> requestBody, String key) async {
    try {
      DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true, isFirebase: true);
      final response = await _provider.post(
        context, Scope.DEEP_LINK, "shortLinks?key=$key", requestBody);
      return DeepLinkResponse.fromJson(response);
    } catch (e) {
      print(e);
    }
  }
}
