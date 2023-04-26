import 'package:flutter/material.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class DraftLoadingWidget extends StatelessWidget {
  const DraftLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: FullScreenSpinner(),
    );
  }
}
