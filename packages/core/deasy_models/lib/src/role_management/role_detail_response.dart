import 'dart:convert';

import 'package:deasy_pocket/deasy_pocket.dart';

RoleDetailResponse roleDetailResponseFromJson(String str) => RoleDetailResponse.fromJson(json.decode(str));

String roleDetailResponseToJson(RoleDetailResponse data) => json.encode(data.toJson());

class RoleDetailResponse {
  RoleDetailResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  RoleDetailData? data;

  factory RoleDetailResponse.fromJson(Map<String, dynamic> json) => RoleDetailResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : RoleDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class RoleDetailData {
  RoleDetailData({
    this.roleId,
    this.name,
    this.isRoot,
    this.status,
    this.dashboardPermission,
    this.menuPermission,
  });

  String? roleId;
  String? name;
  bool? isRoot;
  bool? status;
  RoleDetailDashboardPermission? dashboardPermission;
  MenuPermission? menuPermission;

  factory RoleDetailData.fromJson(Map<String, dynamic> json) => RoleDetailData(
    roleId: json["role_id"] == null ? null : json["role_id"],
    name: json["name"] == null ? null : json["name"],
    isRoot: json["is_root"] == null ? null : json["is_root"],
    status: json["status"] == null ? null : json["status"],
    dashboardPermission: json["dashboard_permission"] == null ? null : RoleDetailDashboardPermission.fromJson(json["dashboard_permission"]),
    menuPermission: json["menu_permission"] == null ? null : MenuPermission.fromJson(json["menu_permission"]),
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId == null ? null : roleId,
    "name": name == null ? null : name,
    "is_root": isRoot == null ? null : isRoot,
    "status": status == null ? null : status,
    "dashboard_permission": dashboardPermission == null ? null : dashboardPermission!.toJson(),
    "menu_permission": menuPermission == null ? null : menuPermission!.toJson(),
  };

  Future<bool> toSharedPref() async {
    return await DeasyPocket().setRoleDetail(this.toJson());
  }

}

class MenuPermission {
  MenuPermission({
    this.sourceApplication,
    this.merchantUserManagement,
    this.ecommerceClientKey,
    this.userManagement,
    this.callback,
    this.roleManagement,
    this.dealerManagement,
  });

  bool? sourceApplication;
  bool? merchantUserManagement;
  bool? ecommerceClientKey;
  bool? userManagement;
  bool? callback;
  bool? roleManagement;
  bool? dealerManagement;

  factory MenuPermission.fromJson(Map<String, dynamic> json) => MenuPermission(
    sourceApplication: json["source_application"] == null ? null : json["source_application"],
    merchantUserManagement: json["merchant_user_management"] == null ? null : json["merchant_user_management"],
    ecommerceClientKey: json["ecommerce_client_key"] == null ? null : json["ecommerce_client_key"],
    userManagement: json["user_management"] == null ? null : json["user_management"],
    callback: json["callback"] == null ? null : json["callback"],
    roleManagement: json["role_management"] == null ? null : json["role_management"],
    dealerManagement: json["dealer_management"] == null ? null : json["dealer_management"],
  );

  Map<String, dynamic> toJson() => {
    "source_application": sourceApplication == null ? null : sourceApplication,
    "merchant_user_management": merchantUserManagement == null ? null : merchantUserManagement,
    "ecommerce_client_key": ecommerceClientKey == null ? null : ecommerceClientKey,
    "user_management": userManagement == null ? null : userManagement,
    "callback": callback == null ? null : callback,
    "role_management": roleManagement == null ? null : roleManagement,
    "dealer_management": dealerManagement == null ? null : dealerManagement,
  };


  Future<bool> toSharedPref() async {
    return await DeasyPocket().setRoleMenuPermission(this.toJson());
  }

}

class RoleDetailDashboardPermission {
  RoleDetailDashboardPermission({
    this.offline,
    this.snb,
    this.online,
    this.po,
    this.invoice,
    this.viewBast,
    this.uploadBast,
    this.viewBuktiTerima,
    this.uploadBuktiTerima,
    this.viewImei,
    this.uploadImei,
  });

  bool? offline;
  bool? snb;
  bool? online;
  bool? po;
  bool? invoice;
  bool? viewBast;
  bool? uploadBast;
  bool? viewBuktiTerima;
  bool? uploadBuktiTerima;
  bool? viewImei;
  bool? uploadImei;

  factory RoleDetailDashboardPermission.fromJson(Map<String, dynamic> json) => RoleDetailDashboardPermission(
    offline: json["offline"] == null ? null : json["offline"],
    snb: json["snb"] == null ? null : json["snb"],
    online: json["online"] == null ? null : json["online"],
    po: json["po"] == null ? null : json["po"],
    invoice: json["invoice"] == null ? null : json["invoice"],
    viewBast: json["view_bast"] == null ? null : json["view_bast"],
    uploadBast: json["upload_bast"] == null ? null : json["upload_bast"],
    viewBuktiTerima: json["view_bukti_terima"] == null ? null : json["view_bukti_terima"],
    uploadBuktiTerima: json["upload_bukti_terima"] == null ? null : json["upload_bukti_terima"],
    viewImei: json["view_imei"] == null ? null : json["view_imei"],
    uploadImei: json["upload_imei"] == null ? null : json["upload_imei"],
  );

  Map<String, dynamic> toJson() => {
    "offline": offline == null ? null : offline,
    "snb": snb == null ? null : snb,
    "online": online == null ? null : online,
    "po": po == null ? null : po,
    "invoice": invoice == null ? null : invoice,
    "view_bast": viewBast == null ? null : viewBast,
    "upload_bast": uploadBast == null ? null : uploadBast,
    "view_bukti_terima": viewBuktiTerima == null ? null : viewBuktiTerima,
    "upload_bukti_terima": uploadBuktiTerima == null ? null : uploadBuktiTerima,
    "view_imei": viewImei == null ? null : viewImei,
    "upload_imei": uploadImei == null ? null : uploadImei,
  };

  Future<bool> toSharedPref() async {
    return await DeasyPocket().setRoleDashboardPermission(this.toJson());
  }
}
