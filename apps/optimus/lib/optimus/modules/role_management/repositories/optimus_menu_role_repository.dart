import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusMenuRoleRepository {
  DioClient _provider = DioClient();

  Future<OptimusRoleResponse> getMenuPermission(
      BuildContext context, String userId) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, 'roles/user/$userId', null);
    return OptimusRoleResponse.fromJson(response);
  }

  Future<OptimusRoleDetailResponse> getDetailRole(
      BuildContext? context, String? roleId) async {
    final response = await _provider
        .post(context, Scope.MERCHANT, "roles/detail", {"role_id": roleId});
    return OptimusRoleDetailResponse.fromJson(response);
  }
}
