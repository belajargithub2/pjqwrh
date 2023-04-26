import 'dart:convert';

OptimusLoginResponse loginResponseFromJson(String str) => OptimusLoginResponse.fromJson(json.decode(str));

String loginResponseToJson(OptimusLoginResponse data) => json.encode(data.toJson());

class OptimusLoginResponse {
  OptimusLoginResponse({
    this.code,
    this.message,
    this.data,
    this.error,
  });

  int? code;
  String? message;
  LoginData? data;
  Error? error;

  factory OptimusLoginResponse.fromJson(Map<String, dynamic> json) => OptimusLoginResponse(
    code: json["code"] ?? null,
    message: json["message"] ?? null,
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code ?? null,
    "message": message ?? null,
    "data": data == null ? null : data!.toJson(),
    "error": error == null ? null : error!.toJson(),
  };
}

class LoginData {
  LoginData(
      {this.id,
        this.supplierId,
        this.name,
        this.email,
        this.isMerchantOnline,
        this.isVerified,
        this.isShowMenuSubsidiDealer,
        this.role,
        this.roleId,
        this.accessToken,
        this.refreshToken,
        this.expire,
        this.deviceId,
        this.lastLoginDate,
        this.code,
        this.message,
        this.agentId,
        this.nik,
        this.userType,
        this.merchantBranchId,
        this.isNewWg,
        this.croId,
        this.croName,
        this.supplierName,
        this.supplierAddress,
      });

  String? id;
  String? supplierId;
  String? name;
  String? email;
  bool? isMerchantOnline;
  bool? isVerified;
  bool? isShowMenuSubsidiDealer;
  String? role;
  String? roleId;
  String? accessToken;
  String? refreshToken;
  int? expire;
  String? deviceId;
  DateTime? lastLoginDate;
  String? code;
  String? message;
  int? agentId;
  String? nik;
  String? userType;
  String? merchantBranchId;
  bool? isNewWg;
  String? croId;
  String? croName;
  String? supplierName;
  String? supplierAddress;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"] ?? null,
    supplierId: json["supplier_id"] ?? null,
    name: json["name"] ?? null,
    email: json["email"] ?? null,
    isMerchantOnline: json["is_merchant_online"] ?? null,
    isVerified: json["is_verified"] ?? null,
    isShowMenuSubsidiDealer: json["is_show_menu_dealer_subsidy"] ?? null,
    role: json["role"] ?? null,
    roleId: json["role_id"] ?? null,
    accessToken: json["access_token"] ?? null,
    refreshToken: json["refresh_token"] ?? null,
    expire: json["expire"] ?? null,
    deviceId: json["device_id"] ?? null,
    lastLoginDate: json["last_login_date"] == null
        ? null
        : DateTime.parse(json["last_login_date"]),
    code: json["code"] ?? null,
    message: json["message"] ?? null,
    agentId: json["agent_id"] ?? null,
    nik: json["nik"] ?? null,
    userType: json["user_type"] ?? null,
    merchantBranchId: json["merchant_branch_id"] ?? '',
    isNewWg: json["is_new_wg"] ?? false,
    croId: json["cro_id"] ?? '',
    croName: json["cro_name"] ?? '',
    supplierName: json["supplier_name"] ?? '',
    supplierAddress: json["supplier_address"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? null,
    "supplier_id": supplierId ?? null,
    "name": name ?? null,
    "email": email ?? null,
    "is_merchant_online": isMerchantOnline ?? null,
    "is_verified": isVerified ?? null,
    "is_show_menu_dealer_subsidy": isShowMenuSubsidiDealer ?? null,
    "role": role ?? null,
    "role_id": roleId ?? null,
    "access_token": accessToken ?? null,
    "refresh_token": refreshToken ?? null,
    "expire": expire ?? null,
    "device_id": deviceId ?? null,
    "last_login_date":
    lastLoginDate == null ? null : lastLoginDate!.toIso8601String(),
    "code": code ?? null,
    "message": message ?? null,
    "agent_id": agentId ?? null,
    "nik": nik ?? null,
    "user_type": userType ?? null,
    "merchant_branch_id": merchantBranchId ?? '',
    "is_new_wg": isNewWg ?? false,
    "cro_id": croId ?? '',
    "cro_name": croName ?? '',
    "supplier_name": supplierName ?? '',
    "supplier_address": supplierAddress ?? '',
  };
}

class Error {
  Error({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] ?? null,
    message: json["message"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "code": code ?? null,
    "message": message ?? null,
  };
}
