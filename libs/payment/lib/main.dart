import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static MethodChannel channel = const MethodChannel('deasy.newwg');
  String txt = 'CALL';

  callMe() async {
    try {
      String r = Random().nextInt(100).toString();
      String call = await channel.invokeMethod("tv", "SUXESS $r");
      setState(() {
        txt = call;
      });
      await Future.delayed(const Duration(seconds: 3));
      finish();
    } catch (e) {
      print(e);
    }
  }

  void finish() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Image.asset('assets/images/animasi.gif'),
              Image.asset('assets/images/qr.png'),
              const Text("INI PEMBATAS"),
              ElevatedButton(
                onPressed: () => callMe(),
                child: Text(txt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
