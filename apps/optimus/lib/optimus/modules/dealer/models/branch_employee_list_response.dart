import 'dart:convert';

BranchEmployeeListResponse branchEmployeeListResponseFromJson(String str) => BranchEmployeeListResponse.fromJson(json.decode(str));

String branchEmployeeListResponseToJson(BranchEmployeeListResponse data) => json.encode(data.toJson());

class BranchEmployeeListResponse {
  BranchEmployeeListResponse({
    this.code,
    this.message,
    this.data,
    this.pageInfo,
  });

  int? code;
  String? message;
  List<BranchEmployeeData>? data;
  PageInfo? pageInfo;

  factory BranchEmployeeListResponse.fromJson(Map<String, dynamic> json) => BranchEmployeeListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<BranchEmployeeData>.from(json["data"].map((x) => BranchEmployeeData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class BranchEmployeeData {
  BranchEmployeeData({
    this.croId,
    this.employeeName,
    this.branchId,
    this.isActive,
  });

  String? croId;
  String? employeeName;
  String? branchId;
  bool? isActive;

  factory BranchEmployeeData.fromJson(Map<String, dynamic> json) => BranchEmployeeData(
    croId: json["cro_id"] == null ? null : json["cro_id"],
    employeeName: json["employee_name"] == null ? null : json["employee_name"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "cro_id": croId == null ? null : croId,
    "employee_name": employeeName == null ? null : employeeName,
    "branch_id": branchId == null ? null : branchId,
    "is_active": isActive == null ? null : isActive,
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
  dynamic limit;
  int? page;
  dynamic prevPage;
  dynamic nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"],
    nextPage: json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit,
    "page": page == null ? null : page,
    "prev_page": prevPage,
    "next_page": nextPage,
  };
}
