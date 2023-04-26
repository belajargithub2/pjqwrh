import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/bindings/optimus_email_verification_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/bindings/merchant_user_management_add_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/bindings/merchant_user_management_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/views/screens/merchant_user_management_add_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/views/screens/merchant_user_management_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/screens/konfirmasi_konsumen_newwg_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/views/optimus_email_verification_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/screens/stepper_newwg_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/bindings/optimus_automail_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/screens/optimus_request_otp_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/bindings/optimus_new_password_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/views/optimus_new_password_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/bindings/optimus_register_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/optimus_register_merchant.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/automail/optimus_automail_screen.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/bindings/optimus_snb_base_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/optimus_snb_container_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/bindings/optimus_callback_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/views/optimus_callback_detail_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/views/optimus_callback_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/bindings/optimus_drawer_custom_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/bindings/optimus_forgot_password_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/views/optimus_forget_password_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/bindings/optimus_login_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/screens/optimus_login_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/views/optimus_add_or_update_source_application_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/views/optimus_source_application_page.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/bindings/dashboard_cancel_request_web_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/dashboard_cancel_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/dashboard_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/bindings/dealer_management_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/views/dealer_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/views/edit_dealer_management_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/bindings/optimus_create_or_update_ecommerce_client_key_web_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/bindings/optimus_e_commerce_client_key_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/views/optimus_create_or_update_e_comm_client_key_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/views/optimus_e_comm_client_key_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/bindings/optimus_profile_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/views/optimus_profile_main_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/bindings/optimus_role_management_add_or_update_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/bindings/optimus_role_management_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/optimus_role_management_add_or_update.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/optimus_role_management_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/bindings/optimus_maintenance_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/bindings/optimus_versioning_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/bindings/optimus_subsidi_dealer_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/maintenance/optimus_maintenance_screen_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/versioning/optimus_versioning_screen_web.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/optimus_subsidi_dealer_container_view.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/bindings/optimus_source_application_binding.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/bindings/optimus_add_or_update_user_management_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/bindings/optimus_user_management_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/views/create_or_update_user/optimus_user_management_create_or_update_view.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/views/user_management/optimus_user_management_container_view.dart';
import 'package:kreditplus_deasy_website/core/widgets/error/500.dart';
import 'package:stepper/stepper.dart';
import 'package:verification_customer/verification_customer.dart';

class OptimusAppPages {
  OptimusAppPages._();

  static final routes = [
    GetPage(
        name: OptimusPaths.CONFIRMATION_CUSTOMER_NEWWG,
        page: () => KonfirmasiKonsumenNewwgScreen(),
        binding: CustomerConfirmationBinding()),
    GetPage(
        name: OptimusPaths.HUMAN_VERIFICATION_NEWWG,
        page: () => StepperNewwgScreen(),
        binding: StepperContainerBinding()),
    GetPage(
        name: OptimusPaths.FORGOT_PASSWORD,
        page: () => OptimusForgotPasswordPage(),
        binding: OptimusForgotPasswordBinding()),
    GetPage(
        name: OptimusPaths.LOGIN,
        page: () => OptimusLoginPage(),
        binding: OptimusLoginBinding()),
    GetPage(
        name: OptimusPaths.LOGIN_OTP,
        page: () => OptimusRequestOtpPage(),
        binding: OptimusLoginBinding()),
    GetPage(
        name: Paths.DASHBOARD_WEB,
        page: () => DashboardWeb(),
        binding: DashboardBinding()),
    GetPage(
        name: Paths.DASHBOARD_CANCEL_REQUEST,
        transition: Transition.rightToLeft,
        binding: DashboardCancelRequestWebBinding(),
        page: () => DashboardCancelRequestWeb()),
    GetPage(
        name: OptimusPaths.SOURCE_APPLICATION,
        binding: OptimusSourceApplicationBinding(),
        page: () => OptimusSourceApplicationPage()),
    GetPage(
        name: OptimusPaths.CREATE_SOURCE_APPLICATION,
        transition: Transition.rightToLeft,
        binding: OptimusSourceApplicationBinding(),
        page: () => OptimusAddOrUpdateSourceApplicationPage()),
    GetPage(
        name: OptimusPaths.EDIT_SOURCE_APPLICATION,
        transition: Transition.rightToLeft,
        binding: OptimusSourceApplicationBinding(),
        page: () => OptimusAddOrUpdateSourceApplicationPage()),
    GetPage(
        name: Paths.DEALER_MANAGEMENT,
        page: () => DealerManagementWeb(),
        binding: DealerManagementBinding()),
    GetPage(
        name: Paths.EDIT_DEALER_MANAGEMENT,
        transition: Transition.rightToLeft,
        binding: DealerManagementBinding(),
        page: () => EditDealerManagementWeb()),
    GetPage(
        name: OptimusPaths.ROLE_MANAGEMENT,
        transition: Transition.rightToLeft,
        binding: OptimusRoleManagementBinding(),
        page: () => OptimusRoleManagementWeb()),
    GetPage(
        name: OptimusPaths.ROLE_MANAGEMENT_ADD_OR_UPDATE,
        page: () => OptimusRoleManagementAddOrUpdate(),
        binding: OptimusRoleManagementAddOrUpdateBinding()),
    GetPage(
        name: OptimusPaths.CALLBACK,
        page: () => OptimusCallbackWeb(),
        binding: OptimusCallbackBinding()),
    GetPage(
        name: OptimusPaths.CALLBACK_DETAIL,
        page: () => OptimusCallbackDetailWeb(),
        binding: OptimusCallbackBinding()),
    GetPage(
        name: OptimusPaths.ECOMMERCE_CLIENT_KEY,
        binding: OptimusECommerceClientKeyWebBinding(),
        page: () => OptimusECommerceClientKeyWeb()),
    GetPage(
        name: OptimusPaths.CREATE_ECOMMERCE_CLIENT_KEY,
        transition: Transition.rightToLeft,
        binding: OptimusCreateOrUpdateEcommerceClientKeyWebBinding(),
        page: () => OptimusCreateOrUpdateECommerceClientKeyWeb()),
    GetPage(
        name: OptimusPaths.SNAP_AND_BUY_WEB,
        transition: Transition.rightToLeft,
        binding: OptimusSnapAndBuyBaseBinding(),
        page: () => OptimusSnapAndBuyContainerScreen()),
    GetPage(
        name: OptimusPaths.EDIT_ECOMMERCE_CLIENT_KEY,
        transition: Transition.rightToLeft,
        binding: OptimusCreateOrUpdateEcommerceClientKeyWebBinding(),
        page: () => OptimusCreateOrUpdateECommerceClientKeyWeb()),
    GetPage(
        name: OptimusPaths.USER_MANAGEMENT,
        transition: Transition.rightToLeft,
        binding: OptimusUserManagementBinding(),
        page: () => OptimusUserManagementContainerView()),
    GetPage(
        name: OptimusPaths.EDIT_USER_MANAGEMENT,
        transition: Transition.rightToLeft,
        binding: OptimusAddOrUpdateUserManagementBinding(),
        page: () => OptimusCreateOrUpdateUserManagementView()),
    GetPage(
        name: OptimusPaths.CREATE_USER_MANAGEMENT,
        transition: Transition.rightToLeft,
        binding: OptimusAddOrUpdateUserManagementBinding(),
        page: () => OptimusCreateOrUpdateUserManagementView()),
    GetPage(
        name: OptimusPaths.SUBSIDI_DEALER,
        transition: Transition.rightToLeft,
        binding: OptimusSubsidiDealerBinding(),
        page: () => OptimusSubsidiDealerContainerView()),
    GetPage(name: ErrorPage500.routeName, page: () => ErrorPage500()),
    GetPage(
        name: OptimusPaths.REGISTER_MERCHANT_PAGE,
        page: () => OptimusRegisterMerchant(),
        binding: OptimusRegisterBinding()),
    GetPage(
        name: OptimusPaths.EMAIL_VERIFICATION_PAGE,
        page: () => OptimusEmailVerificationContainer(),
        binding: OptimusEmailVerificationBinding()),
    GetPage(
        name: OptimusPaths.NEW_PASSWORD,
        page: () => OptimusNewPasswordPage(),
        binding: OptimusNewPasswordBinding()),
    GetPage(
        name: OptimusPaths.DRAWER_CUSTOM,
        page: () => OptimusDrawerCustom(),
        binding: OptimusDrawerCustomBinding()),
    GetPage(
        name: Paths.PROFILE,
        page: () => OptimusProfileMainScreen(),
        binding: OptimusProfileBinding()),
    GetPage(
        name: OptimusPaths.VERSIONING,
        page: () => OptimusVersioningScreenWeb(),
        binding: OptimusVersioningBinding()),
    GetPage(
        name: OptimusPaths.MAINTENANCE,
        page: () => OptimusMaintenanceScreenWeb(),
        binding: OptimusMaintenanceBinding()),
    GetPage(
        name: OptimusPaths.AUTO_MAIL,
        page: () => OptimusAutomailScreen(),
        binding: OptimusAutomailBinding()),
    GetPage(
        name: OptimusPaths.MERCHANT_USER_MANAGEMENT,
        page: () => MerchantUserManagementScreen(),
        binding: MerchantUserManagementBinding()),
    GetPage(
      name: OptimusPaths.VERIFICATION_CUSTOMER,
      page: () => VerificationCustomerScreen(),
      binding: VerificationCustomerBinding()),
    GetPage(
      name: OptimusPaths.MERCHANT_USER_MANAGEMENT_ADD,
      page: () => MerchantUserManagementAddScreen(),
      binding: MerchantUserManagementAddBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 500)),
  ];
}
