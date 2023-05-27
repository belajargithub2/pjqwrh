import 'package:dailycheckin/ui/termcondition_screen.dart';
import 'package:flutter/material.dart';

import '../ui/dailycheckin_screen.dart';
import '../ui/home_screen.dart';

class RoutingGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String? route;
    Map<String, String>? queryParameter;
    if (settings.name != null) {
      var uriData = Uri.parse(settings.name!);
      route = uriData.path;
      queryParameter = uriData.queryParameters;
    }

    switch (route) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);
      case DailyCheckInScreen.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                DailyCheckInScreen(queryParameters: queryParameter),
            settings: settings);
      case TermConditionScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const TermConditionScreen(),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);
    }
  }
}
