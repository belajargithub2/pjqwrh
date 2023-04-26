abstract class Constant {
  static const ROLE_SUPER_ADMIN = "super admin";
  static const ROLE_MERCHANT = "merchant";
  static const ROLE_MERCHANT_EMPLOYEE = "merchant employee";
  static const ROLE_HELPDESK_SUPPORT = "helpdesk support";
  static const ROLE_AGENT = "agent";
}

abstract class KEY_PREFERENCES {
  static const String isShowDp = "isShowDp";
  static const String isMaintenanceMode = "isMaintenanceMode";
  static const String useSnb = "useSnb";
  static const String qrCodeTimer = "qrCodeTimer";
  static const String retryGenerateQrCount = "retryGenerateQrCount";
  static const String merchantBranchId = "merchantBranchId";
  static const String roleId = "roleId";
  static const String offline = "offline";
  static const String snb = "snb";
  static const String online = "online";
  static const String po = "po";
  static const String requestCancel = "request_cancel";
  static const String invoice = "invoice";
  static const String viewBast = "view_bast";
  static const String viewBuktiTerima = "view_bukti_terima";
  static const String viewImei = "view_imei";
  static const String uploadBast = "upload_bast";
  static const String uploadBuktiTerima = "upload_bukti_terima";
  static const String uploadImei = "upload_imei";
  static const String roleMenuPermission = "roleMenuPermission";
  static const String roleDashboardPermission = "roleDashboardPermission";
  static const String roleDetail = "roleDetail";
  static const String isDealerSubsidies = "isDealerSubsidies";
  static const String otpTimer = "otp_timer";
  static const String useNewwg = "newwg";
  static const String newWgAuthConfigs = "new_wg_auth_configs";
  static const String newWgDataConfigs = "new_wg_data_configs";
  static const String prospectIdNewWg = "prospect_id_new_wg";
  static const String resendEmailCount = "resend_count";
  static const String resendEmailRetryAt = "resend_retry_at";
}
