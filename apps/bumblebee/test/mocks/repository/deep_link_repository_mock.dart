
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';

class DeepLinkRepositoryMock implements DeepLinkRepository {

  @override
  Future<DeepLinkResponse> createLink(BuildContext? context, Map<String, dynamic> requestBody, String key) {
    return Future.value(DeepLinkResponse(
      shortLink: "https://deasy.page.link/8RMgwRn2ms4pcRed8",
      previewLink: "https://deasy.page.link"
    ));
  }
}
