import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class NotificationRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<NotificationListResponse> fetchNotificationList(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "notifications", requestBody);
    return NotificationListResponse.fromJson(response);
  }

  Future<NotificationReadResponse> patchNotifRead(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.patch(
        context, Scope.MERCHANT, "notifications/read", requestBody);

    return NotificationReadResponse.fromJson(response);
  }

  Future<NotificationCountResponse> getCountNotif(BuildContext? context) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "notifications/count", null);
    return NotificationCountResponse.fromJson(response);
  }

  Future<bool> deleteNotif(BuildContext? context, String? id) async {
    final response = await _provider.deleteWithoutQuery(
        context, Scope.MERCHANT, "notifications/delete/$id", null);
    if (response != null) {
      return true;
    }
    return false;
  }
}
