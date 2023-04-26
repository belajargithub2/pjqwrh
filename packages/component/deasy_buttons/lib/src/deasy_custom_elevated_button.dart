import 'package:flutter/material.dart';

class DeasyCustomElevatedButton extends StatelessWidget {
  Color? primary;
  Color? borderColor;
  Function? onPress;
  double paddingButton;
  double fontSize;
  double radius;
  String? text;
  Key? myKey;
  bool enable;
  Color? textColor;
  Widget? endWidget;

  DeasyCustomElevatedButton({
    this.primary,
    this.paddingButton = 15,
    this.borderColor,
    this.onPress,
    this.myKey,
    this.radius = 10,
    this.text,
    this.textColor,
    this.enable = true,
    this.fontSize = 14,
    this.endWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        key: myKey == null
            ? Key('${text!.toLowerCase().trim()}')
            : myKey,
        style: ElevatedButton.styleFrom(
          primary: primary,
          side: BorderSide(width: 1, color: borderColor!),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: () {
          if (enable) {
            onPress!();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(paddingButton),
          child: endWidget != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        text!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: textColor, fontSize: fontSize),
                      ),
                    ),
                    SizedBox(width: 5),
                    if (endWidget!= null) Expanded(flex: 1, child: endWidget!),
                  ],
                )
              : Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor, fontSize: fontSize),
                ),
        ));
  }
}