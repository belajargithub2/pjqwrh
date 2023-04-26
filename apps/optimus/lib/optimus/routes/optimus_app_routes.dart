class OptimusRoutes {
  OptimusRoutes._();

  static const REGISTER_MERCHANT_PAGE = OptimusPaths.REGISTER_MERCHANT_PAGE;
  static const EMAIL_VERIFICATION_PAGE = OptimusPaths.EMAIL_VERIFICATION_PAGE;
  static const LOGIN = OptimusPaths.LOGIN;
  static const LOGIN_OTP = OptimusPaths.LOGIN_OTP;
  static const NEW_PASSWORD = OptimusPaths.NEW_PASSWORD;
  static const SNAP_AND_BUY_WEB = OptimusPaths.SNAP_AND_BUY_WEB;
  static const FORGOT_PASSWORD = OptimusPaths.FORGOT_PASSWORD;
  static const DRAWER_CUSTOM = OptimusPaths.DRAWER_CUSTOM;
  static const SOURCE_APPLICATION = OptimusPaths.SOURCE_APPLICATION;
  static const CREATE_SOURCE_APPLICATION =
      OptimusPaths.CREATE_SOURCE_APPLICATION;
  static const EDIT_SOURCE_APPLICATION = OptimusPaths.EDIT_SOURCE_APPLICATION;
  static const USER_MANAGEMENT = OptimusPaths.USER_MANAGEMENT;
  static const EDIT_USER_MANAGEMENT = OptimusPaths.EDIT_USER_MANAGEMENT;
  static const CREATE_USER_MANAGEMENT = OptimusPaths.CREATE_USER_MANAGEMENT;
  static const CALLBACK = OptimusPaths.CALLBACK;
  static const CALLBACK_DETAIL = OptimusPaths.CALLBACK_DETAIL;
  static const SUBSIDI_DEALER = OptimusPaths.SUBSIDI_DEALER;
  static const ECOMMERCE_CLIENT_KEY = OptimusPaths.ECOMMERCE_CLIENT_KEY;
  static const CREATE_ECOMMERCE_CLIENT_KEY =
      OptimusPaths.CREATE_ECOMMERCE_CLIENT_KEY;
  static const EDIT_ECOMMERCE_CLIENT_KEY =
      OptimusPaths.EDIT_ECOMMERCE_CLIENT_KEY;
  static const VERSIONING = OptimusPaths.VERSIONING;
  static const MAINTENANCE = OptimusPaths.MAINTENANCE;
  static const ROLE_MANAGEMENT = OptimusPaths.ROLE_MANAGEMENT;
  static const ROLE_MANAGEMENT_ADD_OR_UPDATE =
      OptimusPaths.ROLE_MANAGEMENT_ADD_OR_UPDATE;
  static const AUTOMAIL = OptimusPaths.AUTO_MAIL;
  static const MERCHANT_USER_MANAGEMENT = OptimusPaths.MERCHANT_USER_MANAGEMENT;
  static const DASHBOARD_WEB = OptimusPaths.DASHBOARD_WEB;
  static const VERIFICATION_CUSTOMER = OptimusPaths.VERIFICATION_CUSTOMER;
  static const CONFIRMATION_CUSTOMER_NEWWG = OptimusPaths.CONFIRMATION_CUSTOMER_NEWWG;
  static const HUMAN_VERIFICATION_NEWWG = OptimusPaths.HUMAN_VERIFICATION_NEWWG;
  static const MERCHANT_USER_MANAGEMENT_ADD =
      OptimusPaths.MERCHANT_USER_MANAGEMENT_ADD;
}

class OptimusPaths {
  static const REGISTER_MERCHANT_PAGE = '/optimus_register_merchant_page';
  static const EMAIL_VERIFICATION_PAGE = '/email-verification-page';
  static const LOGIN = '/login';
  static const LOGIN_OTP = '/login-missed-call';
  static const NEW_PASSWORD = '/new-password/:key/:email/:flag';
  static const SNAP_AND_BUY_WEB = '/snap-and-buy';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const DRAWER_CUSTOM = '/drawer-menu';
  static const SOURCE_APPLICATION = '/source-app';
  static const CREATE_SOURCE_APPLICATION = '/source-app/editorcreate';
  static const EDIT_SOURCE_APPLICATION = '/source-app/editorcreate';
  static const USER_MANAGEMENT = '/user-management';
  static const EDIT_USER_MANAGEMENT = '/user-management/edit';
  static const CREATE_USER_MANAGEMENT = '/user-management/create';
  static const CALLBACK = '/callback';
  static const CALLBACK_DETAIL = '/callback-detail';
  static const SUBSIDI_DEALER = '/subsidi-dealer';
  static const ECOMMERCE_CLIENT_KEY = '/e-commerce-client-key';
  static const CREATE_ECOMMERCE_CLIENT_KEY = '/e-commerce-client-key/create';
  static const EDIT_ECOMMERCE_CLIENT_KEY = '/e-commerce-client-key/edit';
  static const VERSIONING = "/settings/versioning";
  static const MAINTENANCE = "/settings/maintenance";
  static const ROLE_MANAGEMENT = '/role_management';
  static const ROLE_MANAGEMENT_ADD_OR_UPDATE = '/role-management/detail';
  static const AUTO_MAIL = '/settings/auto-mail';
  static const MERCHANT_USER_MANAGEMENT = '/merchant-user-management';
  static const DASHBOARD_WEB = '/dashboard_web';
  static const VERIFICATION_CUSTOMER = '/verification-costumer';
  static const CONFIRMATION_CUSTOMER_NEWWG = '/confirmation-customer-newwg';
  static const HUMAN_VERIFICATION_NEWWG = '/human-verification-newwg';
  static const MERCHANT_USER_MANAGEMENT_ADD = '/merchant-user-management_add';
}
