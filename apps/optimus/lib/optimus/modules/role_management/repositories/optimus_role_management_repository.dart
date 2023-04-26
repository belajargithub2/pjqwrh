import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_get_all_role_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusRoleManagementRepository {
  DioClient _provider = DioClient();

  Future<OptimusResponseGetAllRole> getRoles(BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "roles", null);
    return OptimusResponseGetAllRole.fromJson(response);
  }

  Future<OptimusResponseGetAllRole> getAllRoles(BuildContext? context,Map<String, dynamic> requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "roles/get-all", requestBody);
    return OptimusResponseGetAllRole.fromJson(response);
  }

  Future<OptimusRoleDetailResponse> getDetailRoles(BuildContext? context,Map<String, dynamic> requestBody) async {
    final response = await _provider.post(context, Scope.MERCHANT, "roles/detail", requestBody);
    return OptimusRoleDetailResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> getRolesById(
      BuildContext? context, String uuid) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "roles/$uuid", null);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> createRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "roles/create", requestBody);
    return RoleManagementDataResponse.fromJson(response);
  }

  Future<RoleManagementDataResponse> updateRoles(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "roles/update", requestBody);
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
