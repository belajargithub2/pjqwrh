import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<DeleteAccountResponse> deleteAccount(BuildContext? context,
      Map<String, dynamic>? requestBody, String? id) async {
    final response = await _provider.delete(
        context, Scope.MERCHANT, "users/$id", requestBody,
        getNewErrorMessage: true);
    return DeleteAccountResponse.fromJson(response);
  }

  Future<SendEmailDeleteAccountResponse> sendEmailDeleteAccount(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "mails/delete-user", requestBody,
        getNewErrorMessage: true);
    return SendEmailDeleteAccountResponse.fromJson(response);
  }

  Future<ResponseRegister> userRegister(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent =
        DioClient(isActiveRefreshTokenInterceptor: true, eventName: eventName, params: requestBody);
    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "auth/register", requestBody,
        isReturnError: true, showSnackbar: true, isRegister: true);
    return ResponseRegister.fromJson(response);
  }

  Future<UserChangePasswordResponse> postApiChangePassword(
      BuildContext? context,
      Map<String, dynamic> requestBody,
      String eventName) async {
    DioClient _providerWithEvent =
        DioClient(isActiveRefreshTokenInterceptor: true, eventName: eventName, params: requestBody);
    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "users/change-password", requestBody,
        getNewErrorMessage: true);
    return UserChangePasswordResponse.fromJson(response);
  }

  Future<VerifyPasswordResponse> postApiVerifyPassword(
      BuildContext? context, String? email, String currentPassword) async {
    var requestBody = <String, dynamic>{
      "email": email,
      "current_password": currentPassword
    };

    final response = await _provider.post(
        context, Scope.MERCHANT, "users/verify-password", requestBody);
    return VerifyPasswordResponse.fromJson(response);
  }

  Future<EmptyResponse> updateFcmUser(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "users/fcm-token", requestBody);
    return EmptyResponse.fromJson(response);
  }

  Future<UserDataResponse> getUserById(
      BuildContext? context, String? id) async {
    final response = await _provider
        .get(context, Scope.MERCHANT, "users/$id", null, showSnackbar: true);
    return UserDataResponse.fromJson(response);
  }

  Future<ResponseLogout> logout(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "auth/logout", requestBody);
    return ResponseLogout.fromJson(response);
  }

  Future<HistoriesLoginResponse> postApiHistoryLogout(
    BuildContext? context, {
    int? loginHistoriesId,
    String? appsVersion,
    String? browserType,
    String? browserVersion,
    String? deviceId,
    String? deviceModel,
    String? email,
    bool? isMobile,
    double? latitude,
    double? longitude,
    String? osVersion,
    String? phoneNumber,
  }) async {
    var requestBody = <String, dynamic>{
      "id": loginHistoriesId,
      "apps_version": appsVersion ?? "",
      "browser_type": browserType ?? "",
      "browser_version": browserVersion ?? "",
      "device_id": deviceId ?? "",
      "device_model": deviceModel ?? "",
      "email": email ?? "",
      "is_mobile": isMobile,
      "latitude": latitude,
      "longitude": longitude,
      "os_version": osVersion ?? "",
      "phone_number": phoneNumber ?? "",
    };

    final response = await _provider.post(
        context, Scope.MERCHANT, "histories/logout", requestBody);

    return HistoriesLoginResponse.fromJson(response);
  }

  Future<UserResponse> fetchApiAllUsers(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "users/get-all", requestBody);
    return UserResponse.fromJson(response);
  }

  Future<UserGetLobTypesResponse> fetchApiLobTypes(BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "users/lob-types", null);
    return UserGetLobTypesResponse.fromJson(response);
  }

  Future<UserCreateResponse> postApiCreateUser(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "users", requestBody, showSnackbar: true);
    return UserCreateResponse.fromJson(response);
  }

  Future<UserCreateResponse> postApiUpdateUser(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.patch(
        context, Scope.MERCHANT, "users/edit", requestBody, showSnackbar: true);
    return UserCreateResponse.fromJson(response);
  }

  Future<EmptyResponse> deleteUser(BuildContext? context, String? id) async {
    final response =
        await _provider.delete(context, Scope.MERCHANT, "users/$id", null);
    return EmptyResponse.fromJson(response);
  }
}
