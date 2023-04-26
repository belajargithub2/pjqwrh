import 'dart:convert';

enum ActionNotification { EDIT_SUBMISSION }

OptimusNotificationListResponse notificationListResponseFromJson(String str) => OptimusNotificationListResponse.fromJson(json.decode(str));

String notificationListResponseToJson(OptimusNotificationListResponse data) => json.encode(data.toJson());

class OptimusNotificationListResponse {
  OptimusNotificationListResponse({
    this.message,
    this.data,
    this.pageInfo
  });

  String? message;
  List<NotificationData>? data;
  PageInfo? pageInfo;

  factory OptimusNotificationListResponse.fromJson(Map<String, dynamic> json) => OptimusNotificationListResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null :
      List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class NotificationData {
  NotificationData({
    this.id,
    this.isRead,
    this.message,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.orderStatus,
    this.prospectId,
    this.supplierId,
    this.title,
    this.agentId,
    this.customerName,
    this.assetCode,
    this.action,
  });

  String? id;
  bool? isRead;
  String? message;
  DateTime? orderDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? orderStatus;
  String? prospectId;
  String? supplierId;
  String? title;
  int? agentId;
  String? customerName;
  String? assetCode;
  ActionNotification? action;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"] == null ? null : json["id"],
    isRead: json["is_read"] == null ? null : json["is_read"],
    message: json["message"] == null ? null : json["message"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    orderStatus: json["order_status"] == null ? null : json["order_status"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    title: json["title"] == null ? null : json["title"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    assetCode: json["asset_code"] == null ? null : json["asset_code"],
    action: json["action"] == null || json["action"] == "" ? null : ActionNotification.values.byName(json["action"])
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "is_read": isRead == null ? null : isRead,
    "message": message == null ? null : message,
    "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
    "order_status": orderStatus == null ? null : orderStatus,
    "prospect_id": prospectId == null ? null : prospectId,
    "supplier_id": supplierId == null ? null : supplierId,
    "title": title == null ? null : title,
    "agent_id": agentId == null ? null : agentId,
    "customer_name": customerName == null ? null : customerName,
    "asset_code": assetCode == null ? null : assetCode,
    "action": action == null ? null : action,
  };
}

class PageInfo {
  PageInfo({
    this.totalRecord,
    this.totalPage,
    this.offset,
    this.limit,
    this.page,
    this.prevPage,
    this.nextPage,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  int? prevPage;
  int? nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"] == null ? null : json["prev_page"],
    nextPage: json["next_page"] == null ? null : json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
    "prev_page": prevPage == null ? null : prevPage,
    "next_page": nextPage == null ? null : nextPage,
  };
}