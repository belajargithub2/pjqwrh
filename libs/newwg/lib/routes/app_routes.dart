// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const CUSTOMER_CONFIRMATION_NEW_WG = _Paths.CUSTOMER_CONFIRMATION_NEW_WG;
  static const HUMAN_VERIFICATION_NEW_WG = _Paths.HUMAN_VERIFICATION_NEW_WG;
  static const VERIFICATION_CUSTOMER_NEW_WG = _Paths.VERIFICATION_CUSTOMER_NEW_WG;
}

abstract class _Paths {
  static const CUSTOMER_CONFIRMATION_NEW_WG = '/customer-confirmation';
  static const HUMAN_VERIFICATION_NEW_WG = '/human-verification';
  static const VERIFICATION_CUSTOMER_NEW_WG = '/verification-customer';
}