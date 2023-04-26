import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_asset_response.dart';

class OptimusAssetRepository {

  Future<AssetResponse> postApiMasterAsset(BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT,
        "orders/snap-n-buy/assets",
        requestBody,
        versionApi: VersionApi.V2,
        showSnackbar: true);
    return AssetResponse.fromJson(response);
  }

}
