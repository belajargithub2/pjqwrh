import 'dart:convert';

OptimusResponseGetAllRole responseGetAllRoleFromJson(String str) => OptimusResponseGetAllRole.fromJson(json.decode(str));

String responseGetAllRoleToJson(OptimusResponseGetAllRole data) => json.encode(data.toJson());

class OptimusResponseGetAllRole {
  OptimusResponseGetAllRole({
    this.code,
    this.message,
    this.data,
    this.pageInfo,
  });

  int? code;
  String? message;
  List<RoleManagementData>? data;
  PageInfo? pageInfo;

  factory OptimusResponseGetAllRole.fromJson(Map<String, dynamic> json) => OptimusResponseGetAllRole(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<RoleManagementData>.from(json["data"].map((x) => RoleManagementData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class RoleManagementData {
  RoleManagementData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.isRoot,
    this.permissions,
    this.status
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? name;
  bool? isRoot;
  List<List<String>>? permissions;
  bool? status;

  factory RoleManagementData.fromJson(Map<String, dynamic> json) => RoleManagementData(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    name: json["name"],
    isRoot: json["is_root"],
    permissions: json["permissions"] == null ? null : List<List<String>>.from(json["permissions"].map((x) => List<String>.from(x.map((x) => x)))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
    "name": name,
    "is_root": isRoot,
    "permissions": permissions == null ? null : List<dynamic>.from(permissions!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "status": status,
  };
}

class RoleManagementPermissionResponse {
  RoleManagementPermissionResponse({
    this.message,
  });

  String? message;
  List<RoleManagementData>? data;

  factory RoleManagementPermissionResponse.fromJson(Map<String, dynamic> json) => RoleManagementPermissionResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

class RoleManagementDataResponse {
  int? code;
  String? message;
  RoleManagementData? data;

  RoleManagementDataResponse({this.message, this.data, this.code});

  RoleManagementDataResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new RoleManagementData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
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

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
    "prev_page": prevPage,
    "next_page": nextPage,
  };
}
