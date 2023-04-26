
import 'dart:convert';

DashboardSearchMerchantResponse dashboardSearchMerchantResponseFromJson(String str) => DashboardSearchMerchantResponse.fromJson(json.decode(str));


class DashboardSearchMerchantResponse {
  DashboardSearchMerchantResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.pageInfo,
  });

  int? code;
  String? message;
  List<DashboardSearchMerchantData>? data;
  PageInfo? pageInfo;

  factory DashboardSearchMerchantResponse.fromJson(Map<String, dynamic> json) => DashboardSearchMerchantResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DashboardSearchMerchantData>.from(json["data"].map((x) => DashboardSearchMerchantData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

}

class DashboardSearchMerchantData {
  DashboardSearchMerchantData({
    required this.supplierId,
    required this.name,
    required this.groupName,
    required this.branchId,
  });

  String? supplierId;
  String? name;
  String? groupName;
  String? branchId;

  factory DashboardSearchMerchantData.fromJson(Map<String, dynamic> json) => DashboardSearchMerchantData(
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    name: json["name"] == null ? null : json["name"],
    groupName: json["group_name"] == null ? null : json["group_name"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
  );

}

class PageInfo {
  PageInfo({
    required this.totalRecord,
    required this.totalPage,
    required this.offset,
    required this.limit,
    required this.page,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
  );


}
