import 'dart:convert';

NotificationReadResponse notificationReadResponseFromJson(String str) => NotificationReadResponse.fromJson(json.decode(str));

class NotificationReadResponse {
  NotificationReadResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory NotificationReadResponse.fromJson(Map<String, dynamic> json) => NotificationReadResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.id,
    this.prospectId,
    this.supplierId,
    this.title,
    this.message,
    this.redirectUrl,
    this.orderStatus,
    this.orderDate,
    this.isRead,
  });

  String? id;
  String? prospectId;
  String? supplierId;
  String? title;
  String? message;
  String? redirectUrl;
  String? orderStatus;
  String? orderDate;
  bool? isRead;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    title: json["title"] == null ? null : json["title"],
    message: json["message"] == null ? null : json["message"],
    redirectUrl: json["redirect_url"] == null ? null : json["redirect_url"],
    orderStatus: json["order_status"] == null ? null : json["order_status"],
    orderDate: json["order_date"] == null ? null : json["order_date"],
    isRead: json["is_read"] == null ? null : json["is_read"],
  );
}
