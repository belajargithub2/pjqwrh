import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class MenuRoleRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<RoleResponse> getMenuPermission(
      BuildContext context, String userId) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, 'roles/user/$userId', null);
    return RoleResponse.fromJson(response);
  }

  Future<RoleDetailResponse> getDetailRole(
      BuildContext? context, String? roleId) async {
    final response = await _provider
        .post(context, Scope.MERCHANT, "roles/detail", {"role_id": roleId});
    return RoleDetailResponse.fromJson(response);
  }
}
