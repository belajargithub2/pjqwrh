// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:newwg/module/confirmation/views/customer_confirmation_container.dart';
import 'package:newwg/module/submission/views/submission_view.dart';
import 'package:stepper/binding/stepper_container_binding.dart';
import 'package:verification_customer/verification_customer.dart';
import 'package:additional_documents/additional_documents.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CUSTOMER_CONFIRMATION_NEW_WG;

  static final routes = [
    GetPage(
        name: Routes.CUSTOMER_CONFIRMATION_NEW_WG,
        page: () => const CustomerConfirmationContainer(),
        binding: CustomerConfirmationBinding()),
    GetPage(
        name: Routes.VERIFICATION_CUSTOMER_NEW_WG,
        page: () => const VerificationCustomerScreen(),
        binding: VerificationCustomerBinding()),
    GetPage(
        name: Routes.HUMAN_VERIFICATION_NEW_WG,
        page: () => const SubmissionView(),
        binding: StepperContainerBinding()),
    ...NewWgAdditionalDocsAppPages.routes,
  ];
}
