import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:deasy_color/deasy_color.dart';

/// Base class for input decoration.
InputDecoration underlinedDropDownDecoration(BuildContext context,
    {String labelText = ""}) {
  return InputDecoration(
    alignLabelWithHint: true,
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      height: 0.5,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    hintStyle: TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: 14.0,
      height: kIsWeb ? 3 : 2,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    suffixIconConstraints: BoxConstraints.tightFor(width: 12, height: 0),
    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    contentPadding: EdgeInsets.only(top: 16, bottom: 12.0),
    isDense: true,
    errorStyle: TextStyle(
      color: Theme.of(context).errorColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).errorColor),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
  );
}

InputDecoration outlinedDropDownDecoration(BuildContext context) {
  return InputDecoration(
    hintStyle: TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: 14.0,
      height: 2,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,
        color: HexColor("#8B8B8B"), size: 24),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    isDense: false,
    contentPadding: EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 0),
    errorStyle: TextStyle(
      color: Theme.of(context).errorColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Theme.of(context).errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
  );
}

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
    labelStyle: TextStyle(
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
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    contentPadding: const EdgeInsets.only(bottom: 12.0),
    isDense: true,
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  );
}

InputDecoration outlinedInputDecoration(
    {required BuildContext context,
    String? hinText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String prefixText = "",
    bool isDisabled = false}) {
  return InputDecoration(
    prefixText: prefixText,
    hintText: hinText,
    hintStyle: TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: 14.0,
      height: 2,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    fillColor: isDisabled ? HexColor("#E3E3E3") : DeasyColor.neutral000,
    filled: isDisabled ? true : false,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    isDense: true,
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.2,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blue),
    ),
  );
}

SystemUiOverlayStyle baseSystemUiOverlayStyle() {
  return SystemUiOverlayStyle(
      statusBarColor: DeasyColor.semanticInfo300,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light);
}
