import 'dart:convert';

OptimusRoleResponse roleResponseFromJson(String str) => OptimusRoleResponse.fromJson(json.decode(str));

String roleResponseToJson(OptimusRoleResponse data) => json.encode(data.toJson());

class OptimusRoleResponse {
  OptimusRoleResponse({
    this.message,
    this.data,
  });

  final String? message;
  final Data? data;

  factory OptimusRoleResponse.fromJson(Map<String, dynamic> json) => OptimusRoleResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.permissions,
  });

  final Permissions? permissions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    permissions: json["permissions"] == null ? null : Permissions.fromJson(json["permissions"]),
  );

  Map<String, dynamic> toJson() => {
    "permissions": permissions == null ? null : permissions!.toJson(),
  };
}

class Permissions {
  Permissions({
    this.admin,
    this.callback,
    this.cancelApplication,
    this.dashboards,
    this.ecommClientKey,
    this.marketing,
    this.merchants,
    this.roles,
    this.sourceApplication,
    this.uploadBast,
    this.users,
    this.snapAndBuy,
    this.transaction,
    this.kpx,
  });

  final List<String>? admin;
  final List<String>? callback;
  final List<String>? cancelApplication;
  final List<String>? dashboards;
  final List<String>? ecommClientKey;
  final List<String>? marketing;
  final List<String>? merchants;
  final List<String>? roles;
  final List<String>? sourceApplication;
  final List<String>? uploadBast;
  final List<String>? users;
  final List<String>? snapAndBuy;
  final List<String>? transaction;
  final List<String>? kpx;

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
    admin: json["admin"] == null ? null : List<String>.from(json["admin"].map((x) => x)),
    callback: json["callback"] == null ? null : List<String>.from(json["callback"].map((x) => x)),
    cancelApplication: json["cancel_application"] == null ? null : List<String>.from(json["cancel_application"].map((x) => x)),
    dashboards: json["dashboards"] == null ? null : List<String>.from(json["dashboards"].map((x) => x)),
    ecommClientKey: json["ecomm_client_key"] == null ? null : List<String>.from(json["ecomm_client_key"].map((x) => x)),
    marketing: json["marketing"] == null ? null : List<String>.from(json["marketing"].map((x) => x)),
    merchants: json["merchants"] == null ? null : List<String>.from(json["merchants"].map((x) => x)),
    roles: json["roles"] == null ? null : List<String>.from(json["roles"].map((x) => x)),
    sourceApplication: json["source_application"] == null ? null : List<String>.from(json["source_application"].map((x) => x)),
    uploadBast: json["upload_bast"] == null ? null : List<String>.from(json["upload_bast"].map((x) => x)),
    users: json["users"] == null ? null : List<String>.from(json["users"].map((x) => x)),
    snapAndBuy: json["snap_and_buy"] == null ? null : List<String>.from(json["snap_and_buy"].map((x) => x)),
    transaction: json["transaction"] == null ? null : List<String>.from(json["transaction"].map((x) => x)),
    kpx: json["kpx"] == null ? null : List<String>.from(json["kpx"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "admin": admin == null ? null : List<dynamic>.from(admin!.map((x) => x)),
    "callback": callback == null ? null : List<dynamic>.from(callback!.map((x) => x)),
    "cancel_application": cancelApplication == null ? null : List<dynamic>.from(cancelApplication!.map((x) => x)),
    "dashboards": dashboards == null ? null : List<dynamic>.from(dashboards!.map((x) => x)),
    "ecomm_client_key": ecommClientKey == null ? null : List<dynamic>.from(ecommClientKey!.map((x) => x)),
    "marketing": marketing == null ? null : List<dynamic>.from(marketing!.map((x) => x)),
    "merchants": merchants == null ? null : List<dynamic>.from(merchants!.map((x) => x)),
    "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
    "source_application": sourceApplication == null ? null : List<dynamic>.from(sourceApplication!.map((x) => x)),
    "upload_bast": uploadBast == null ? null : List<dynamic>.from(uploadBast!.map((x) => x)),
    "users": users == null ? null : List<dynamic>.from(users!.map((x) => x)),
    "snap_and_buy": snapAndBuy == null ? null : List<dynamic>.from(snapAndBuy!.map((x) => x)),
    "transaction": transaction == null ? null : List<dynamic>.from(transaction!.map((x) => x)),
    "kpx": kpx == null ? null : List<dynamic>.from(kpx!.map((x) => x)),
  };
}
