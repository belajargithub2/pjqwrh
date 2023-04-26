import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/deep_link/deep_link_response.dart';
import 'package:kreditplus_deasy_website/core/repositories/deep_link_repository.dart';

class DeepLinkRepositoryMock implements DeepLinkRepository {

  @override
  Future<DeepLinkResponse> createLink(BuildContext? context, Map<String, dynamic> requestBody, String key) {
    return Future.value(DeepLinkResponse(
      shortLink: "https://deasy.page.link/8RMgwRn2ms4pcRed8",
      previewLink: "https://deasy.page.link"
    ));
  }
}
