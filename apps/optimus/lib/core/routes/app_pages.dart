import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_pages.dart';

class AppPages {
  AppPages._();

  static const INITIAL = OptimusRoutes.LOGIN;

  static final notFoundRoute =
  GetPage(name: Routes.NOT_FOUND, page: () => ErrorPage404());

  static final routes = OptimusAppPages.routes;
}
