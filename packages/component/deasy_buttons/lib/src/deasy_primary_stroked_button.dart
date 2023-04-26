import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';

class DeasyPrimaryStrokedButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color backgroundColor;
  final Function onPressed;
  final TextStyle? textStyle;
  final double radius;
  final double width;
  final EdgeInsetsGeometry padding;

  const DeasyPrimaryStrokedButton(
      {required this.text,
      required this.onPressed,
      this.color,
      this.backgroundColor = Colors.white,
      this.textStyle,
      this.radius = 8.0,
      this.width = double.infinity,
      this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width),
        child: Container(
          height: DeasySizeConfigUtils.isDesktopOrWeb ? 50.0 : 40,
          child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
                side: MaterialStateProperty.all<BorderSide>(BorderSide(
                    color: color == null
                        ? Theme.of(context).buttonColor
                        : color!)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius))))),
            child: Text(text!,
                style: textStyle == null
                    ? TextStyle(
                        fontSize: 14, color: Theme.of(context).buttonColor)
                    : textStyle),
            onPressed: () {
              if (onPressed != null) onPressed();
            },
          ),
        ),
      ),
    );
  }
}