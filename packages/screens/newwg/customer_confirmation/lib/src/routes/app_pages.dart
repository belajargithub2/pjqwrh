import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class NewWgCustomerConfirmationAppPages {
  NewWgCustomerConfirmationAppPages._();

  static const INITIAL = NewWgCustomerConfirmationRoutes.NEWWG_CUSTOMER_CONFIRMATION;

  static final routes = [
    GetPage(
      name: _Paths.NEWWG_CUSTOMER_CONFIRMATION,
      page: () => const CustomerConfirmationScreen(),
      binding: CustomerConfirmationBinding(),
    ),
  ];
}