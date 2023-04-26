class BumblebeeRoutes {
  BumblebeeRoutes._();

  //Account & Authentication
  static const PRE_REGISTER_PAGE = BumblebeePaths.PRE_REGISTER_PAGE;
  static const REGISTER_AGENT_PAGE = BumblebeePaths.REGISTER_AGENT_PAGE;
  static const REGISTER_MERCHANT_PAGE = BumblebeePaths.REGISTER_MERCHANT_PAGE;
  static const EMAIL_VERIFICATION_PAGE = BumblebeePaths.EMAIL_VERIFICATION_PAGE;
  static const LOGIN = BumblebeePaths.LOGIN;
  static const OTP = BumblebeePaths.OTP;
  static const OTP_LANDING = BumblebeePaths.OTP_LANDING;

  static const NEW_PASSWORD = BumblebeePaths.NEW_PASSWORD;
  static const FORGOT_PASSWORD = BumblebeePaths.FORGOT_PASSWORD;
  static const PROFILE_FORGOT_PASSWORD = BumblebeePaths.PROFILE_FORGOT_PASSWORD;
  static const DELETE_ACCOUNT = BumblebeePaths.DELETE_ACCOUNT;

  //Features
  static const SNAP_AND_BUY_WEB = BumblebeePaths.SNAP_AND_BUY_WEB;
  static const ECOMMERCE_CLIENT_KEY_MOBILE = BumblebeePaths.ECOMMERCE_CLIENT_KEY_MOBILE;
  static const NOTIFICATION = BumblebeePaths.NOTIFICATION;
  static const DETAIL_TRANSACTION = BumblebeePaths.DETAIL_TRANSACTION;
  static const CANCEL_TRANSACTION = BumblebeePaths.CANCEL_TRANSACTION;
  static const AGENT_FEE = BumblebeePaths.AGENT_FEE;
  static const AGENT_FEE_DETAIL = BumblebeePaths.AGENT_FEE_DETAIL;
  static const MERCHANT_USER_MANAGEMENT = BumblebeePaths.MERCHANT_USER_MANAGEMENT;
  static const ADD_MERCHANT_USER_MANAGEMENT = BumblebeePaths.ADD_MERCHANT_USER_MANAGEMENT;
  static const HUMAN_VERIFICATION_NEW_WG = BumblebeePaths.HUMAN_VERIFICATION_NEW_WG;
  static const VERIFICATION_CUSTOMER_NEW_WG = BumblebeePaths.VERIFICATION_CUSTOMER_NEW_WG;
  static const CUSTOMER_CONFIRMATION_NEW_WG = BumblebeePaths.CUSTOMER_CONFIRMATION_NEW_WG;
  static const CONFIRMATION_CUSTOMER_NEW_WG = BumblebeePaths.CONFIRMATION_CUSTOMER_NEW_WG;
  static const ORDER_NEW_WG = BumblebeePaths.ORDER_NEW_WG;
}

class BumblebeePaths {
  //Account & Authentication
  static const PRE_REGISTER_PAGE = "/pre_register_page";
  static const REGISTER_AGENT_PAGE = "/register_agent_page";
  static const REGISTER_MERCHANT_PAGE = '/bumblebee_register_merchant_page';
  static const EMAIL_VERIFICATION_PAGE = '/email-verification-page';
  static const LOGIN = '/login/:key/:email/:flag';
  static const OTP = '/otp';
  static const OTP_LANDING = '/otp_landing';

  static const NEW_PASSWORD = '/new-password/:key/:email/:flag';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const PROFILE_FORGOT_PASSWORD = '/profile-forgot-password';
  static const DELETE_ACCOUNT = "/delete_account";
  
  //Features
  static const SNAP_AND_BUY_WEB = '/snap-and-buy';
  static const ECOMMERCE_CLIENT_KEY_MOBILE = "/ecommerce_client_key_mobile";
  static const NOTIFICATION = "/notification";
  static const DETAIL_TRANSACTION = "/detail-transaction";
  static const CANCEL_TRANSACTION = '/transaction-cancel';
  static const AGENT_FEE = '/agent-fee';
  static const AGENT_FEE_DETAIL = '/agent-fee-detail';
  static const MERCHANT_USER_MANAGEMENT = '/merchant-user-management';
  static const ADD_MERCHANT_USER_MANAGEMENT = '/add-merchant-user-management';
  static const HUMAN_VERIFICATION_NEW_WG = '/human-verification';
  static const VERIFICATION_CUSTOMER_NEW_WG = '/verification-customer';
  static const CUSTOMER_CONFIRMATION_NEW_WG = '/customer-confirmation';
  static const CONFIRMATION_CUSTOMER_NEW_WG = '/confirmation-customer';
  static const ORDER_NEW_WG = '/order';
}
