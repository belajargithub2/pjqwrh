import 'package:flutter/material.dart';

import 'loading/loading_widget.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        LoadingWidget(),
      ],
    );
  }
}
