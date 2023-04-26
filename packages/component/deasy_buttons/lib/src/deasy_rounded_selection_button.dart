import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

class DeasyRoundedSelectionButton extends StatelessWidget {
  final String btnImage;
  final String btnTitle;
  final Function() onPressed;
  final Color sideColor;

  const DeasyRoundedSelectionButton(
      {Key? key,
      required this.btnImage,
      required this.btnTitle,
      required this.sideColor,
      required this.onPressed})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Image.asset(btnImage),
          Text(btnTitle, style: TextStyle(fontSize: 16, color: DeasyColor.neutral900))
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)))),
        minimumSize: MaterialStateProperty.all(Size(127, 128)),
        side: MaterialStateProperty.all(BorderSide(color: sideColor)),
        backgroundColor: MaterialStateProperty.all(DeasyColor.neutral000),
      ),
    );
  }
}
