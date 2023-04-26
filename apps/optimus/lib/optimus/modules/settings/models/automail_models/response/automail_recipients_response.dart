import 'package:meta/meta.dart';
import 'dart:convert';

AutomailRecipientsResponse automailRecipientsResponseFromJson(String str) =>
    AutomailRecipientsResponse.fromJson(json.decode(str));

class AutomailRecipientsResponse {
  AutomailRecipientsResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.pageInfo,
  });

  int? code;
  String? message;
  List<RecipientData>? data;
  PageInfo? pageInfo;

  factory AutomailRecipientsResponse.fromJson(Map<String, dynamic> json) =>
      AutomailRecipientsResponse(
        code: json["code"],
        message: json["message"],
        data: List<RecipientData>.from(json["data"].map((x) => RecipientData.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["page_info"]),
      );
}

class RecipientData {
  RecipientData({
    required this.id,
    required this.recipientType,
    required this.supplierId,
    required this.name,
    required this.isEnable,
  });

  int id;
  String? recipientType;
  String? supplierId;
  String? name;
  bool? isEnable;

  factory RecipientData.fromJson(Map<String, dynamic> json) => RecipientData(
        id: json["id"]  ,
        recipientType: json["recipient_type"],
        supplierId: json["supplier_id"],
        name: json["name"],
        isEnable: json["is_enable"],
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

  int totalRecord;
  int totalPage;
  int offset;
  int limit;
  int page;
  dynamic prevPage;
  dynamic nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalRecord: json["total_record"],
        totalPage: json["total_page"],
        offset: json["offset"],
        limit: json["limit"],
        page: json["page"],
        prevPage: json["prev_page"],
        nextPage: json["next_page"],
      );
}
