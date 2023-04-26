
import 'dart:convert';

OptimusRequestRoleManagement requestRoleManagementFromJson(String str) => OptimusRequestRoleManagement.fromJson(json.decode(str));

String requestRoleManagementToJson(OptimusRequestRoleManagement data) => json.encode(data.toJson());

class OptimusRequestRoleManagement {
  OptimusRequestRoleManagement({
    this.dashboardPermission,
    this.menuPermission,
    this.roleName,
    this.roleId,
    this.status,
  });

  DashboardPermission? dashboardPermission;
  MenuPermission? menuPermission;
  String? roleName;
  String? roleId;
  bool? status;

  factory OptimusRequestRoleManagement.fromJson(Map<String, dynamic> json) => OptimusRequestRoleManagement(
    dashboardPermission: DashboardPermission.fromJson(json["dashboard_permission"]),
    menuPermission: MenuPermission.fromJson(json["menu_permission"]),
    roleName: json["role_name"],
    roleId: json["role_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "dashboard_permission": dashboardPermission!.toJson(),
    "menu_permission": menuPermission!.toJson(),
    "role_name": roleName,
    "role_id": roleId,
    "status": status,
  };
}

class DashboardPermission {
  DashboardPermission({
    this.invoice,
    this.offline,
    this.online,
    this.po,
    this.snb,
    this.uploadBast,
    this.uploadBuktiTerima,
    this.viewBast,
    this.viewBuktiTerima,
    this.requestCancel,
    this.uploadImei,
    this.viewImei,
  });

  bool? invoice;
  bool? offline;
  bool? online;
  bool? po;
  bool? snb;
  bool? uploadBast;
  bool? uploadBuktiTerima;
  bool? viewBast;
  bool? viewBuktiTerima;
  bool? requestCancel;
  bool? uploadImei;
  bool? viewImei;

  factory DashboardPermission.fromJson(Map<String, dynamic> json) => DashboardPermission(
    invoice: json["invoice"],
    offline: json["offline"],
    online: json["online"],
    po: json["po"],
    snb: json["snb"],
    uploadBast: json["upload_bast"],
    uploadBuktiTerima: json["upload_bukti_terima"],
    viewBast: json["view_bast"],
    viewBuktiTerima: json["view_bukti_terima"],
    requestCancel: json["request_cancel"],
    uploadImei: json["upload_imei"],
    viewImei: json["view_imei"],
  );

  Map<String, dynamic> toJson() => {
    "invoice": invoice,
    "offline": offline,
    "online": online,
    "po": po,
    "snb": snb,
    "upload_bast": uploadBast,
    "upload_bukti_terima": uploadBuktiTerima,
    "view_bast": viewBast,
    "view_bukti_terima": viewBuktiTerima,
    "request_cancel": requestCancel,
    "upload_imei": uploadImei,
    "view_imei": viewImei,
  };
}

class MenuPermission {
  MenuPermission({
    this.callback,
    this.dealerManagement,
    this.ecommerceClientKey,
    this.merchantUserManagement,
    this.roleManagement,
    this.sourceApplication,
    this.userManagement,
    this.subsidyDealer,
  });

  bool? callback;
  bool? dealerManagement;
  bool? ecommerceClientKey;
  bool? merchantUserManagement;
  bool? roleManagement;
  bool? sourceApplication;
  bool? userManagement;
  bool? subsidyDealer;

  factory MenuPermission.fromJson(Map<String, dynamic> json) => MenuPermission(
    callback: json["callback"],
    dealerManagement: json["dealer_management"],
    ecommerceClientKey: json["ecommerce_client_key"],
    merchantUserManagement: json["merchant_user_management"],
    roleManagement: json["role_management"],
    sourceApplication: json["source_application"],
    userManagement: json["user_management"],
    subsidyDealer: json["subsidy_dealer"],
  );

  Map<String, dynamic> toJson() => {
    "callback": callback,
    "dealer_management": dealerManagement,
    "ecommerce_client_key": ecommerceClientKey,
    "merchant_user_management": merchantUserManagement,
    "role_management": roleManagement,
    "source_application": sourceApplication,
    "user_management": userManagement,
    "subsidy_dealer": subsidyDealer,
  };
}
