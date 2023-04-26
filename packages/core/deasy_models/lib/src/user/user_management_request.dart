import 'dart:convert';

UserManagementRequest userManagementRequestFromJson(String str) => UserManagementRequest.fromJson(json.decode(str));

String userManagementRequestToJson(UserManagementRequest data) => json.encode(data.toJson());

class UserManagementRequest {
  UserManagementRequest({
    this.supplier,
    this.name,
    this.nik,
    this.phoneNumber,
    this.email,
    this.role,
    this.createPasswordUrl,
    this.groupName,
    this.branchId,
    this.branchName,
    this.regionId,
    this.regionName,
    this.lobType,
    this.token,
    this.id,
  });

  UserManagementSupplier? supplier;
  String? name;
  String? nik;
  String? phoneNumber;
  String? email;
  UserManagementRole? role;
  String? createPasswordUrl;
  String? groupName;
  String? branchId;
  String? branchName;
  String? regionId;
  String? regionName;
  String? lobType;
  String? token;
  String? id;

  factory UserManagementRequest.fromJson(Map<String, dynamic> json) => UserManagementRequest(
    supplier: json["supplier"] == null ? null : UserManagementSupplier.fromJson(json["supplier"]),
    name: json["name"] == null ? null : json["name"],
    nik: json["nik"] == null ? null : json["nik"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : UserManagementRole.fromJson(json["role"]),
    createPasswordUrl: json["create_password_url"] == null ? null : json["create_password_url"],
    groupName: json["group_name"] == null ? null : json["group_name"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchName: json["branch_name"] == null ? null : json["branch_name"],
    regionId: json["region_id"] == null ? null : json["region_id"],
    regionName: json["region_name"] == null ? null : json["region_name"],
    lobType: json["lob_type"] == null ? null : json["lob_type"],
    token: json["token"] == null ? null : json["token"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "supplier": supplier == null ? null : supplier!.toJson(),
    "name": name == null ? null : name,
    "nik": nik == null ? null : nik,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "email": email == null ? null : email,
    "role": role == null ? null : role!.toJson(),
    "create_password_url": createPasswordUrl == null ? null : createPasswordUrl,
    "group_name": groupName == null ? null : groupName,
    "branch_id": branchId == null ? null : branchId,
    "branch_name": branchName == null ? null : branchName,
    "region_id": regionId == null ? null : regionId,
    "region_name": regionName == null ? null : regionName,
    "lob_type": lobType == null ? null : lobType,
    "token": token == null ? null : token,
    "id": id == null ? null : id,
  };
}

class UserManagementRole {
  UserManagementRole({
    this.id,
  });

  String? id;

  factory UserManagementRole.fromJson(Map<String, dynamic> json) => UserManagementRole(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

class UserManagementSupplier {
  UserManagementSupplier({
    this.supplierId,
  });

  String? supplierId;

  factory UserManagementSupplier.fromJson(Map<String, dynamic> json) => UserManagementSupplier(
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
  );

  Map<String, dynamic> toJson() => {
    "supplier_id": supplierId == null ? null : supplierId,
  };
}

FetchAllUserRequest fetchAllUserRequestFromJson(String str) => FetchAllUserRequest.fromJson(json.decode(str));

String fetchAllUserRequestToJson(FetchAllUserRequest data) => json.encode(data.toJson());

class FetchAllUserRequest {
  FetchAllUserRequest({
    this.page,
    this.limit,
    this.roles,
    this.keyword,
    this.orderBy,
  });

  int? page;
  int? limit;
  List<String?>? roles;
  String? keyword;
  List<OrderBy>? orderBy;

  factory FetchAllUserRequest.fromJson(Map<String, dynamic> json) => FetchAllUserRequest(
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
    roles: json["roles"] == null ? null : List<String>.from(json["roles"].map((x) => x)),
    keyword: json["keyword"] == null ? null : json["keyword"],
    orderBy: json["order_by"] == null ? null : List<OrderBy>.from(json["order_by"].map((x) => OrderBy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
    "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
    "keyword": keyword == null ? null : keyword,
    "order_by": orderBy == null ? null : List<dynamic>.from(orderBy!.map((x) => x.toJson())),
  };
}

class OrderBy {
  OrderBy({
    this.columnName,
    this.dir,
  });

  String? columnName;
  String? dir;

  factory OrderBy.fromJson(Map<String, dynamic> json) => OrderBy(
    columnName: json["column_name"] == null ? null : json["column_name"],
    dir: json["dir"] == null ? null : json["dir"],
  );

  Map<String, dynamic> toJson() => {
    "column_name": columnName == null ? null : columnName,
    "dir": dir == null ? null : dir,
  };
}