import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/models/optimus_create_qr_code_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';


class OptimusIdentifierTransaksiRepository {
  DioClient _provider = DioClient();

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
