import 'package:flutter/material.dart';

class ErrorPage500 extends StatelessWidget {
  static const routeName = "/error-500";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Internal Server Error")));
  }
}
