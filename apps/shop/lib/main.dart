import 'package:flutter/material.dart';
import 'package:shop/screens/consume_api_screen.dart';
import 'package:shop/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sosmed',
      initialRoute: "/",
      routes: {
        '/': (context) => const HomeScreen(),
        '/consume-api': (context) => const ConsumeApiScreen(),
      },
    );
  }
}

