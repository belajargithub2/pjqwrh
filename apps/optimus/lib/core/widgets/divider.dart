import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HorizontalDivider extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  final Color? color;

  const HorizontalDivider(
      {Key? key,
      this.verticalPadding = 0,
      this.horizontalPadding = 0,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      width: double.infinity,
      color: color == null ? HexColor("#E3E3E3") : color,
    );
  }
}
