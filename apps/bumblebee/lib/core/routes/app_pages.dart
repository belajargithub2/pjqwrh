import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_pages.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/error/404.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final notFoundRoute =
  GetPage(name: Routes.NOT_FOUND, page: () => ErrorPage404());

  static final routes = BumblebeeAppPages.routes;
}
