import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class BumblebeeMediaImageRepository {
  DioClient _provider = DioClient();

  Future<Uint8List?> getImagesUint8List(BuildContext? context, String? url) async {
    final response = await _provider.getImage(context, Scope.MERCHANT, "documents/qrcode?path_url=$url");
    return response;
  }
}