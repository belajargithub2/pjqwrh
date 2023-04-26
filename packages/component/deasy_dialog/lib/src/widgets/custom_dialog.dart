import 'package:flutter/material.dart';

class DeasyCustomContentDialog extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Widget content;

  const DeasyCustomContentDialog({
    this.width = 300.0,
    this.height = 190.0,
    this.radius = 10.0,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(24),
        child: content,
      ),
    );
  }
}
