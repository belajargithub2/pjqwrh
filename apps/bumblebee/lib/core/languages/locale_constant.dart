import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "id";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('id', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  App.setLocale(context, _locale);
}

/// change language example
// var locale = await getLocale();
// if (locale == Locale("id", "")) {
// changeLanguage(context, "en");
// } else {
// changeLanguage(context, "id");
// }
