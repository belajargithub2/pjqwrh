import 'package:additional_documents/additional_documents.dart';
import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/bindings/bumblebee_merchant_user_management_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/views/bumblebee_add_merchant_user_management_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/views/bumblebee_merchant_user_management_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/bindings/agent_fee_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/bindings/agent_fee_detail_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/views/agent_fee_detail_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/views/agent_fee_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/bindings/bumblebee_email_verification_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/views/bumblebee_email_verification_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/bindings/bumblebee_forgot_passowrd_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/views/bumblebee_forget_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/views/bumblebee_profile_forgot_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/screens/bumblebee_login_otp_landing_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_password/bindings/bumblebee_new_password_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_password/views/bumblebee_new_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_wg_submission/views/customer_confirmation.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_wg_submission/views/new_wg_stepper.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/bindings/bumblebee_register_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/screens/pre_register_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/screens/register_agent_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/screens/bumblebee_register_merchant.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/bindings/bumblebee_login_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/screens/bumblebee_login_otp_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/screens/bumblebee_login_page.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/bindings/account_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/account_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/change_password/change_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/change_password/input_current_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/delete_account/delete_account_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/ecommerce_client_key/ecommerce_client_key_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/success/success_reset_password_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/bindings/bumblebee_home_container_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/bindings/bumblebee_home_page_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/bumble_beehome_container_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/bumblebee_home_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/bindings/bumblebee_kmob_review_image_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/bindings/bumblebee_kmob_submission_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/bindings/bumblebee_kmob_take_image_from_camera_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_review_image/kmob_review_image_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_submission_container_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_take_image/kmob_take_image_from_camera.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/bindings/bumblebee_notification_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/views/bumblebee_notification_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/bindings/bumblebee_on_boarding_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/views/bumblebee_on_boarding_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/bindings/bumblebee_splash_screen_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/views/bumblebee_splash_screen_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/bindings/bumblebee_cancel_transaction_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/bindings/bumblebee_detail_transaction_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/bindings/bumblebee_transaction_image_preview_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/bindings/bumblebee_transaction_pdf_preview_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/views/bumblebee_cancel_transaction.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/views/bumblebee_detail_transaction.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/transaction_image_preview.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/transaction_pdf_preview.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/bindings/bumblebee_snb_base_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/bumblebee_snb_container_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/bindings/upload_photo_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/list_upload_tabview.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/upload_photo_camera_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/upload_photo_review_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/generate_qr_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/incoming_page.dart';
import 'package:order/order.dart';
import 'package:stepper/binding/stepper_container_binding.dart';
import 'package:verification_customer/verification_customer.dart';

class BumblebeeAppPages {
  BumblebeeAppPages._();

  static final routes = [
    ...NewWgAdditionalDocsAppPages.routes,
    GetPage(
        name: BumblebeePaths.SNAP_AND_BUY_WEB,
        transition: Transition.rightToLeft,
        binding: BumblebeeSnapAndBuyBaseBinding(),
        page: () => BumblebeeSnapAndBuyContainerScreen()),
    GetPage(
        name: Paths.SPLASH_SCREEN,
        page: () => BumblebeeSplashScreen(),
        binding: BumblebeeSplashScreenBinding()),
    GetPage(
      name: Paths.HOME_CONTAINER,
      page: () => BumblebeeHomeContainerPage(),
      binding: BumblebeeHomeContainerBinding(),
    ),
    GetPage(
      name: Paths.ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
        name: BumblebeeRoutes.LOGIN,
        page: () => BumblebeeLoginPage(),
        binding: BumblebeeLoginBinding()),
    GetPage(
        name: BumblebeeRoutes.OTP,
        page: () => BumblebeeLoginOTPPage(),
        binding: BumblebeeLoginBinding()),
    GetPage(
        name: BumblebeeRoutes.OTP_LANDING,
        page: () => BumblebeeLoginOTPLandingPage(),
        binding: BumblebeeLoginBinding()),
    GetPage(
        name: Routes.TRANSACTION_PDF,
        page: () => TransactionPdfPreviewPage(),
        binding: BumblebeeTransactionPdfPreviewBinding()),
    GetPage(
      name: Routes.HOME,
      page: () => BumblebeeHomePage(),
      binding: BumblebeeHomePageBinding(),
    ),
    GetPage(
        name: Routes.LIST_UPLOAD,
        page: () => ListUploadTabView(),
        binding: UploadPhotoBinding()),
    GetPage(
        name: BumblebeeRoutes.NOTIFICATION,
        page: () => BumblebeeNotificationPage(),
        binding: BumblebeeNotificationBinding()),
    GetPage(
        name: BumblebeeRoutes.ECOMMERCE_CLIENT_KEY_MOBILE,
        page: () => EcommerceClientKeyPage(),
        binding: AccountBinding()),
    GetPage(
        name: Paths.RESET_PASSWORD,
        page: () => ChangePasswordPage(),
        binding: AccountBinding()),
    GetPage(
        name: Paths.INPUT_CURRENT_PASSWORD,
        page: () => InputCurrentPasswordPage(),
        binding: AccountBinding()),
    GetPage(
        name: Paths.RESET_PASSWORD_SUCCESS,
        page: () => SuccessResetPasswordPage()),
    GetPage(
        name: BumblebeePaths.FORGOT_PASSWORD,
        page: () => BumblebeeForgotPasswordPage(),
        binding: BumblebeeForgotPasswordBinding()),
    GetPage(
        name: BumblebeePaths.PROFILE_FORGOT_PASSWORD,
        page: () => BumblebeeProfileForgotPasswordPage(),
        binding: BumblebeeForgotPasswordBinding()),
    GetPage(
        name: Routes.UPLOAD_PHOTO_CAMERA,
        page: () => UploadPhotoCameraPage(),
        binding: UploadPhotoBinding()),
    GetPage(
        name: BumblebeePaths.DETAIL_TRANSACTION,
        page: () => BumblebeeDetailTransaction(),
        binding: BumblebeeDetailTransactionBinding()),
    GetPage(
        name: BumblebeePaths.CANCEL_TRANSACTION,
        page: () => BumblebeeCancelTransaction(),
        binding: BumblebeeCancelTransactionBinding()),
    GetPage(
        name: Routes.UPLOAD_PHOTO_REVIEW,
        page: () => UploadPhotoReviewPage(),
        binding: UploadPhotoBinding()),
    GetPage(
        name: BumblebeePaths.REGISTER_MERCHANT_PAGE,
        page: () => BumblebeeRegisterMerchant(),
        binding: BumblebeeRegisterBinding()),
    GetPage(
        name: BumblebeePaths.EMAIL_VERIFICATION_PAGE,
        page: () => BumblebeeEmailVerificationScreen(),
        binding: BumblebeeEmailVerificationBinding()),
    GetPage(
        name: BumblebeePaths.NEW_PASSWORD,
        page: () => BumbleBeeNewPasswordPage(),
        binding: BumblebeeNewPasswordBinding()),
    GetPage(
        name: Paths.ON_BOARDING,
        page: () => BumblebeeOnBoardingPage(),
        binding: BumblebeeOnBoardingBinding()),
    GetPage(
      name: IncomingPage.routeName,
      page: () => IncomingPage(),
    ),
    GetPage(
      name: GenerateQRPage.routeName,
      page: () => GenerateQRPage(),
    ),
    GetPage(
        name: Paths.TRANSACTION_PREVIEW_IMAGE,
        page: () => TransactionImagePreview(),
        binding: BumblebeeTransactionImagePreviewBinding()),
    GetPage(
        name: BumblebeePaths.PRE_REGISTER_PAGE,
        page: () => PreRegisterPage(),
        binding: BumblebeeRegisterBinding()),
    GetPage(
        name: BumblebeePaths.REGISTER_AGENT_PAGE,
        page: () => RegisterAgentPage(),
        binding: BumblebeeRegisterBinding()),
    GetPage(
        name: Paths.KMOB_SUBMISSION,
        page: () => KMOBSubmissionContainerScreen(),
        binding: BumblebeeKMOBSubmissionBinding()),
    GetPage(
        name: Paths.KMOB_SUBMISSION_UPLOAD_IMAGE_FROM_CAMERA,
        page: () => KMOBTakeImageFromCameraScreen(),
        binding: BumblebeeKMOBTakeImageFromCameraBinding()),
    GetPage(
        name: Paths.KMOB_SUBMISSION_REVIEW_IMAGE,
        page: () => KMOBReviewImageScreen(),
        binding: BumblebeeKMOBReviewImageBinding()),
    GetPage(
        name: BumblebeePaths.DELETE_ACCOUNT,
        page: () => DeleteAccountPage(),
        binding: AccountBinding()),
    GetPage(
        name: BumblebeePaths.AGENT_FEE,
        page: () => AgentFeeScreen(),
        binding: AgentFeeBinding()),
    GetPage(
        name: BumblebeePaths.AGENT_FEE_DETAIL,
        page: () => AgentFeeDetailScreen(),
        transition: Transition.rightToLeft,
        binding: AgentFeeDetailBinding()),
    GetPage(
        name: BumblebeePaths.MERCHANT_USER_MANAGEMENT,
        page: () => BumblebeeMerchantUserManagementScreen(),
        binding: BumblebeeMerchantUserManagementBinding()),
    GetPage(
        name: BumblebeePaths.ADD_MERCHANT_USER_MANAGEMENT,
        page: () => BumblebeeAddMerchantUserManagementScreen(),
        binding: BumblebeeMerchantUserManagementBinding()),
    GetPage(
        name: BumblebeePaths.HUMAN_VERIFICATION_NEW_WG,
        page: () => NewWgStepperScreen(),
        binding: StepperContainerBinding()),
    GetPage(
        name: BumblebeePaths.CONFIRMATION_CUSTOMER_NEW_WG,
        page: () => CustomerConfirmation(),
        binding: CustomerConfirmationBinding()),
    GetPage(
      name: BumblebeePaths.VERIFICATION_CUSTOMER_NEW_WG,
      page: () => VerificationCustomerScreen(),
      binding: VerificationCustomerBinding()),
    GetPage(
      name: BumblebeePaths.ORDER_NEW_WG,
      page: () => const OrderScreen(),
      binding: OrderBinding(),
    ),
  ];
}
