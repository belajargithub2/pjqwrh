import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class NotificationRepositoryMock with Mock implements NotificationRepository {
  @override
  Future<NotificationListResponse> fetchNotificationList(BuildContext? context, Map<String, dynamic>? requestBody) {
    return Future.value(NotificationListResponse(
      message: "OK",
      data: [
        NotificationData(
          id: "9b5c2e38-2d2f-4210-933e-bcef03314f99",
          isRead: false,
          message: "Halo, Pengajuan sudah disetujui silakan mengunggah dokumen BAST di menu transaksi",
          orderDate: DateTime.parse("2022-03-16T14:16:47Z"),
          createdAt: DateTime.parse("2022-03-16T14:18:11.077447+07:00"),
          updatedAt: DateTime.parse("2022-11-03T13:41:24.755625+07:00"),
          deletedAt: null,
          orderStatus: "Approved",
          prospectId: "KPM-TST-DGS8901558",
          supplierId: "42600425",
          title: "KPM-TST-DGS8901558 - Terbayarkan"
        ),
        NotificationData(
          id: "9b5c2e38-2d2f-4210-933e-bcef03314f97",
          isRead: false,
          message: "Hore, Pengajuan KPM-TST-DGS8901555 Status Transaksi sudah dibayarkan dari Kreditplus ke Merchant",
          orderDate: DateTime.parse("2022-03-18T14:16:47Z"),
          createdAt: DateTime.parse("2022-03-18T14:18:11.077447+07:00"),
          updatedAt: DateTime.parse("2022-11-04T13:41:24.755625+07:00"),
          deletedAt: null,
          orderStatus: "Disbursed",
          prospectId: "KPM-TST-DGS8901555",
          supplierId: "42600426",
          title: "KPM-TST-DGS8901555 - Terbayarkan"
        ),
      ],
    pageInfo: NotificationListPageInfo(
      totalRecord: 2,
      totalPage: 1,
      limit: 10,
      page: 1,
      prevPage: 1,
      nextPage: 2
    )
    ));
  }

  @override
  Future<bool> deleteNotif(BuildContext? context, String? id) {
    return Future.value(true);
  }

  @override
  Future<NotificationReadResponse> patchNotifRead(BuildContext? context, Map<String, dynamic> requestBody) {
    return Future.value(NotificationReadResponse(
      message: "OK",
      data: NotificationReadData(
        id: "9b5c2e38-2d2f-4210-933e-bcef03314f99",
        isRead: true,
        message: "Halo, Pengajuan sudah disetujui silakan mengunggah dokumen BAST di menu transaksi",
        orderDate: "2022-03-16T14:16:47Z",
        orderStatus: "Approved",
        prospectId: "KPM-TST-DGS8901558",
        supplierId: "42600425",
        title: "KPM-TST-DGS8901558 - Terbayarkan",
        redirectUrl: "/dashboard"
      )
    ));
  }
}
