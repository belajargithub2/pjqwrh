import 'package:flutter/material.dart';
import '../core/api/api_provider.dart';
import 'routing_generator.dart';

class Routing {
  static MaterialApp init() {
    return MaterialApp(
      initialRoute: '/dailycheckin',
      navigatorKey: navigatorKey,
      onGenerateRoute: RoutingGenerator.generateRoute,
      theme: ThemeData(
        fontFamily: 'KBFG Display'
      ),
    );
  }
}
