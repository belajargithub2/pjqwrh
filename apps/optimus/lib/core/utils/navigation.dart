import 'package:flutter/material.dart';

/// Custom class to handle navigation.
class NavigationUtil {
  /// This function is created to handle un-smooth transition between page,
  /// sometimes the default navigation is laggy (based on user's device)
  /// if the default transition is laggy please use this function to navigate
  /// between pages.
  static PageRouteBuilder fadeInPageRouter(
      {Widget? page, String? routeName, int duration = 700}) {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (context, animation, anotherAnimation) {
          return page!;
        },
        transitionDuration: Duration(milliseconds: duration),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
  }
}
