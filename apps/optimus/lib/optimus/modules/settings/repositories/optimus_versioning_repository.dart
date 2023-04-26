import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/optimus_versioning_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusVersioningRepository {
  DioClient _provider = DioClient();

  Future<OptimusVersioningResponse> getVersion(String os) async {
    final response = await _provider.get(
        Get.context, Scope.MERCHANT, "settings/mobile/$os", null);
    return OptimusVersioningResponse.fromJson(response);
  }

  Future<OptimusVersioningResponse> setVersion(String os, String? ver) async {
    Map<String, String?> body = {"app_name": os, "app_version": ver};
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, "settings/mobile", body);
    return OptimusVersioningResponse.fromJson(response);
  }
}
