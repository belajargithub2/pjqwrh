import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/deep_link/deep_link_response.dart';

import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class DeepLinkRepository {

  Future<DeepLinkResponse?> createLink(BuildContext? context,
    Map<String, dynamic> requestBody, String key) async {
    try {
      DioClient _provider = DioClient(isFirebase: true);
      final response = await _provider.post(
        context, Scope.DEEP_LINK, "shortLinks?key=$key", requestBody);
      return DeepLinkResponse.fromJson(response);
    } catch (e) {
      print(e);
    }
  }
}
