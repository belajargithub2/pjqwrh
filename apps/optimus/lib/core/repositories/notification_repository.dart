import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/notification_count_response.dart';
import 'package:kreditplus_deasy_website/core/model/notification_read_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/models/optimus_notification_list_response.dart';

class NotificationRepository {
  DioClient _provider = DioClient();

  Future<OptimusNotificationListResponse> fetchNotificationList(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "notifications", requestBody);
    return OptimusNotificationListResponse.fromJson(response);
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