import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class RoleManagementRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<ResponseGetDetailRoleManagement> getDetailRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "roles/detail", requestBody);
    return ResponseGetDetailRoleManagement.fromJson(response);
  }

  Future<RoleManagementResponse> getRoles(BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "roles", null);
    return RoleManagementResponse.fromJson(response);
  }

  Future<RoleManagementResponse> getAllRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "roles/get-all", requestBody);
    return RoleManagementResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> getRolesById(
      BuildContext? context, String uuid) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "roles/$uuid", null);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> createRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "roles/create", requestBody);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> updateRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "roles/update", requestBody);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementPermissionResponse> onPermissionRole(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "permissions/grant", requestBody);
    return RoleManagementPermissionResponse.fromJson(response);
  }

  Future<RoleManagementPermissionResponse> offPermissionRole(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.deleteWithoutQuery(
        context, Scope.MERCHANT, "permissions/revoke", requestBody);
    return RoleManagementPermissionResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> setActiveRole(
      BuildContext? context, String? uuid) async {
    final response = await _provider.patch(
        context, Scope.MERCHANT, "roles/active/$uuid", null);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> setNonActiveRole(
      BuildContext? context, String? uuid) async {
    final response = await _provider.deleteWithoutQuery(
        context, Scope.MERCHANT, "roles/$uuid", null);
    return RoleManagementDataResponse.fromJson(response);
  }
}
