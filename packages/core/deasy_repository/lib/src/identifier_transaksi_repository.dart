import 'dart:typed_data';

import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class IdentifierTransaksiRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<CreateQrCodeResponse> postCreateMerchantQrCode(
    BuildContext? context,
    Map<String, dynamic> requestBody,
  ) async {
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "merchants/qr-codes/create",
      requestBody,
      showSnackbar: true,
    );
    return CreateQrCodeResponse.fromJson(response);
  }

  Future<Uint8List?> getImagesUint8List(
    BuildContext? context,
    String? url,
  ) async {
    final response = await _provider.getImage(
      context,
      Scope.MERCHANT,
      "documents/qrcode?path_url=$url",
    );
    return response;
  }
}
