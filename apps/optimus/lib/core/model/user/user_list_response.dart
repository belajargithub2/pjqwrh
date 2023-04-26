import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.code,
    this.message,
    this.data,
    this.pageInfo,
  });

  int? code;
  String? message;
  List<UserItemResponse>? data;
  PageInfo? pageInfo;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<UserItemResponse>.from(json["data"].map((x) => UserItemResponse.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class UserItemResponse {
  UserItemResponse({
    this.id,
    this.supplier,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.groupName,
    this.branchId,
    this.branchName,
    this.regionId,
    this.regionName,
  });

  String? id;
  Supplier? supplier;
  String? name;
  String? email;
  String? phoneNumber;
  Role? role;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? groupName;
  String? branchId;
  String? branchName;
  String? regionId;
  String? regionName;

  factory UserItemResponse.fromJson(Map<String, dynamic> json) => UserItemResponse(
    id: json["id"] == null ? null : json["id"],
    supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    fcmToken: json["FCMToken"] == null ? null : json["FCMToken"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    groupName: json["group_name"] == null ? null : json["group_name"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchName: json["branch_name"] == null ? null : json["branch_name"],
    regionId: json["region_id"] == null ? null : json["region_id"],
    regionName: json["region_name"] == null ? null : json["region_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "supplier": supplier == null ? null : supplier!.toJson(),
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "role": role == null ? null : role!.toJson(),
    "FCMToken": fcmToken == null ? null : fcmToken,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "group_name": groupName == null ? null : groupName,
    "branch_id": branchId == null ? null : branchId,
    "branch_name": branchName == null ? null : branchName,
    "region_id": regionId == null ? null : regionId,
    "region_name": regionName == null ? null : regionName,
  };
}

class Role {
  Role({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Supplier {
  Supplier({
    this.supplierId,
    this.name,
  });

  String? supplierId;
  String? name;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "supplier_id": supplierId == null ? null : supplierId,
    if(name != null) "name": name,
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
