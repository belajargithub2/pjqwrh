import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static Dialog expiredSessionDialog(
      {BuildContext? context, required VoidCallback onButtonPress}) {
    return Dialog(
      backgroundColor: Colors.white,
      child: DeasyBaseDialogs.getInstance().iconDialog(
        context: context!,
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
          size: 30,
        ),
        title: "Sesi Habis",
        subTitle: "Sesi anda telah habis, harap melakukan login ulang.",
        buttonOkText: "Login",
        onPressButtonOk: onButtonPress,
      ),
    );
  }
}
