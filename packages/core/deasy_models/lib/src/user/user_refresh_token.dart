import 'dart:convert';

UserRefreshToken userRefreshTokenFromJson(String str) => UserRefreshToken.fromJson(json.decode(str));

String userRefreshTokenToJson(UserRefreshToken data) => json.encode(data.toJson());

class UserRefreshToken {
  UserRefreshToken({
    this.data,
    this.message,
  });

  UserRefreshTokenData? data;
  String? message;

  factory UserRefreshToken.fromJson(Map<String, dynamic> json) => UserRefreshToken(
    data: json["data"] == null ? null : UserRefreshTokenData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class UserRefreshTokenData {
  UserRefreshTokenData({
    this.accessToken,
    this.code,
    this.deviceId,
    this.email,
    this.expire,
    this.id,
    this.isMerchantOnline,
    this.isVerified,
    this.lastLoginDate,
    this.name,
    this.refreshToken,
    this.role,
    this.roleId,
    this.supplierId,
  });

  String? accessToken;
  String? code;
  String? deviceId;
  String? email;
  int? expire;
  String? id;
  bool? isMerchantOnline;
  bool? isVerified;
  String? lastLoginDate;
  String? name;
  String? refreshToken;
  String? role;
  String? roleId;
  String? supplierId;

  factory UserRefreshTokenData.fromJson(Map<String, dynamic> json) => UserRefreshTokenData(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    code: json["code"] == null ? null : json["code"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    email: json["email"] == null ? null : json["email"],
    expire: json["expire"] == null ? null : json["expire"],
    id: json["id"] == null ? null : json["id"],
    isMerchantOnline: json["is_merchant_online"] == null ? null : json["is_merchant_online"],
    isVerified: json["is_verified"] == null ? null : json["is_verified"],
    lastLoginDate: json["last_login_date"] == null ? null : json["last_login_date"],
    name: json["name"] == null ? null : json["name"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    role: json["role"] == null ? null : json["role"],
    roleId: json["role_id"] == null ? null : json["role_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "code": code == null ? null : code,
    "device_id": deviceId == null ? null : deviceId,
    "email": email == null ? null : email,
    "expire": expire == null ? null : expire,
    "id": id == null ? null : id,
    "is_merchant_online": isMerchantOnline == null ? null : isMerchantOnline,
    "is_verified": isVerified == null ? null : isVerified,
    "last_login_date": lastLoginDate == null ? null : lastLoginDate,
    "name": name == null ? null : name,
    "refresh_token": refreshToken == null ? null : refreshToken,
    "role": role == null ? null : role,
    "role_id": roleId == null ? null : roleId,
    "supplier_id": supplierId == null ? null : supplierId,
  };
}
