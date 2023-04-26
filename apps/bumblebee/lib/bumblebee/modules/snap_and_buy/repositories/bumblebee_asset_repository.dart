import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_asset_response.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeAssetRepository {

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
