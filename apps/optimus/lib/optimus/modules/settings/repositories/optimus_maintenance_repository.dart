import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/optimus_maintenance_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusMaintenanceRepository {
  DioClient _provider = DioClient();

  Future<OptimusMaintenanceResponse> getMaintenances() async {
    final response = await _provider.get(
        Get.context, Scope.MERCHANT, "settings/maintenances", null);
    return OptimusMaintenanceResponse.fromJson(response);
  }

  Future<OptimusMaintenanceResponse> setMaintenances(Map<String, dynamic> body) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, "settings/maintenances", body);
    return OptimusMaintenanceResponse.fromJson(response);
  }
}
