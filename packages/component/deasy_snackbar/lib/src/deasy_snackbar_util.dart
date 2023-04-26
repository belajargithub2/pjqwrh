import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DeasySnackBarUtil {
  static Flushbar? _flush;

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message,
            style:
                TextStyle(fontFamily: 'KBFGDisplayLight', color: Colors.white)),
      ));
  }

  static void showFlushBarError(BuildContext context, String? message) {
    _flush = Flushbar<bool?>(
      message: message,
      mainButton: IconButton(
        icon: Icon(
          Icons.close,
          size: 20.0,
          color: Colors.white,
        ),
        onPressed: () {
          _flush?.dismiss(true);
        },
      ),
      backgroundColor: Theme.of(context).errorColor,
      animationDuration: Duration(milliseconds: 500),
      margin: EdgeInsets.all(24.0),
      duration: Duration(seconds: 3),
      borderRadius: BorderRadius.circular(4.0),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  static void showFlushBarDelete(BuildContext context, Function onUndo) {
    _flush = _flush = Flushbar<bool>(
      message: "Notifikasi Dihapus",
      mainButton: InkWell(
        onTap: () {
          onUndo();
        },
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor("#F46363"))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Undo',
                  style: TextStyle(color: HexColor("#F46363"), fontSize: 12.0)),
            )),
      ),
      messageColor: HexColor("#646464"),
      backgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 500),
      margin: EdgeInsets.all(24.0),
      duration: Duration(seconds: 4),
      borderRadius: BorderRadius.circular(4.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
    )..show(context);
  }

  static Future<void> dismissFlushBar() async {
    await _flush!.dismiss(true);
  }

  static bool isDismissedFlushBar() {
    if (_flush == null) {
      return true;
    } else {
      bool isDismissed = _flush!.isDismissed();
      return isDismissed;
    }
  }
}
