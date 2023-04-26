import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

InputDecoration underlinedInputDecoration(
    {required BuildContext context,
    String? labelText,
    String? hinText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText = ""}) {
  return InputDecoration(
    prefixText: prefixText,
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      height: 1,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    hintText: hinText,
    hintStyle: TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: 14.0,
      height: kIsWeb ? 3 : 2,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    contentPadding: const EdgeInsets.only(bottom: 12.0),
    isDense: true,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  );
}
