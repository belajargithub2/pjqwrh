import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) => UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) => json.encode(data.toJson());

class UserDataResponse {
  UserDataResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => UserDataResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.supplier,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.fcmToken,
    this.verifiedAt,
    this.groupName,
    this.branchId,
    this.branchName,
    this.regionId,
    this.regionName,
    this.userType,
    this.lobTypeName,
    this.agent,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  Supplier? supplier;
  String? name;
  String? email;
  String? phoneNumber;
  Role? role;
  String? fcmToken;
  String? verifiedAt;
  String? groupName;
  String? branchId;
  String? branchName;
  String? regionId;
  String? regionName;
  String? userType;
  String? lobTypeName;
  Agent? agent;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
    verifiedAt: json["verified_at"] == null ? null : json["verified_at"],
    groupName: json["group_name"] == null ? null : json["group_name"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchName: json["branch_name"] == null ? null : json["branch_name"],
    regionId: json["region_id"] == null ? null : json["region_id"],
    regionName: json["region_name"] == null ? null : json["region_name"],
    userType: json["user_type"] == null ? null : json["user_type"],
    lobTypeName: json["lob_type_name"] == null ? null : json["lob_type_name"],
    agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "supplier": supplier == null ? null : supplier!.toJson(),
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "role": role == null ? null : role!.toJson(),
    "fcm_token": fcmToken == null ? null : fcmToken,
    "verified_at": verifiedAt == null ? null : verifiedAt,
    "group_name": groupName == null ? null : groupName,
    "branch_id": branchId == null ? null : branchId,
    "branch_name": branchName == null ? null : branchName,
    "region_id": regionId == null ? null : regionId,
    "region_name": regionName == null ? null : regionName,
    "user_type": userType == null ? null : userType,
    "lob_type_name": lobTypeName == null ? null : lobTypeName,
    "agent": agent == null ? null : agent!.toJson(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}

class Agent {
  Agent({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.createdAt,
  });

  int? id;
  String? name;
  String? nik;
  String? email;
  DateTime? createdAt;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    nik: json["nik"] == null ? null : json["nik"],
    email: json["email"] == null ? null : json["email"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "nik": nik == null ? null : nik,
    "email": email == null ? null : email,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

class Role {
  Role({
    this.id,
    this.name,
    this.isRoot,
    this.createdAt,
  });

  String? id;
  String? name;
  bool? isRoot;
  DateTime? createdAt;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    isRoot: json["is_root"] == null ? null : json["is_root"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "is_root": isRoot == null ? null : isRoot,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

class Supplier {
  Supplier({
    this.supplierId,
    this.supplierName,
    this.useSnb,
  });

  String? supplierId;
  String? supplierName;
  bool? useSnb;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    supplierName: json["supplier_name"] == null ? null : json["supplier_name"],
    useSnb: json["use_snb"] == null ? null : json["use_snb"],
  );

  Map<String, dynamic> toJson() => {
    "supplier_id": supplierId == null ? null : supplierId,
    "supplier_name": supplierName == null ? null : supplierName,
    "use_snb": useSnb == null ? null : useSnb,
  };
}
