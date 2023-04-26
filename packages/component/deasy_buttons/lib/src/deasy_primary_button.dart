import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';

class DeasyPrimaryButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? borderColor;
  final Function onPressed;
  final TextStyle? textStyle;
  final double radius;
  final double width;
  final EdgeInsetsGeometry padding;
  final Widget? leadIcon;
  final Widget? suffixIcon;

  const DeasyPrimaryButton(
      {super.key, required this.text,
      required this.onPressed,
      this.color,
      this.borderColor,
      this.textStyle,
      this.radius = 8.0,
      this.width = double.infinity,
      this.padding = const EdgeInsets.all(0),
      this.leadIcon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width),
        child: SizedBox(
          height: DeasySizeConfigUtils.isDesktopOrWeb ? 50.0 : 40,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                    color ?? Theme.of(context).buttonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: borderColor ?? Theme.of(context).buttonColor),
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius))))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadIcon != null) leadIcon!,
                if (leadIcon != null) const SizedBox(width: 10),
                Text(text!,
                    style: textStyle ?? const TextStyle(fontSize: 14, color: DeasyColor.neutral000)),
                if (suffixIcon != null) const SizedBox(width: 10),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
            onPressed: () {
              onPressed();
            },
          ),
        ),
      ),
    );
  }
}