import 'dart:convert';

OptimusSubsidiesResponse subsidiesResponseFromJson(String str) =>
    OptimusSubsidiesResponse.fromJson(json.decode(str));

class OptimusSubsidiesResponse {
  OptimusSubsidiesResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.pageInfo,
  });

  int? code;
  String? message;
  List<SubsidiesData>? data;
  PageInfo? pageInfo;

  factory OptimusSubsidiesResponse.fromJson(Map<String, dynamic> json) =>
      OptimusSubsidiesResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<SubsidiesData>.from(json["data"].map((x) => SubsidiesData.fromJson(x))),
        pageInfo: json["page_info"] == null
            ? null
            : PageInfo.fromJson(json["page_info"]),
      );
}

class SubsidiesData {
  SubsidiesData({
    required this.itemDescription,
    required this.orderId,
    required this.orderStatus,
    required this.otr,
    required this.ntfAmount,
    required this.totalOtr,
    required this.subsidiAmount,
    required this.orderDate,
    required this.supplierName,
  });

  String? itemDescription;
  String? orderId;
  String? orderStatus;
  int? otr;
  int? ntfAmount;
  int? totalOtr;
  int? subsidiAmount;
  DateTime? orderDate;
  String? supplierName;

  factory SubsidiesData.fromJson(Map<String, dynamic> json) => SubsidiesData(
        itemDescription:
            json["item_description"] == null ? null : json["item_description"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        otr: json["otr"] == null ? null : json["otr"],
        ntfAmount: json["ntf_amount"] == null ? null : json["ntf_amount"],
        totalOtr: json["total_otr"] == null ? null : json["total_otr"],
        subsidiAmount:
            json["subsidi_amount"] == null ? null : json["subsidi_amount"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        supplierName: json["supplier_name"] == null ? null : json["supplier_name"],
      );
}

class PageInfo {
  PageInfo({
    required this.totalRecord,
    required this.totalPage,
    required this.offset,
    required this.limit,
    required this.page,
    required this.prevPage,
    required this.nextPage,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  dynamic prevPage;
  dynamic nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalRecord: json["total_record"] == null ? null : json["total_record"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
        offset: json["offset"] == null ? null : json["offset"],
        limit: json["limit"] == null ? null : json["limit"],
        page: json["page"] == null ? null : json["page"],
        prevPage: json["prev_page"],
        nextPage: json["next_page"],
      );
}
