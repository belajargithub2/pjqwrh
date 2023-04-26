import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/languages/english.dart';
import 'package:kreditplus_deasy_website/core/languages/indonesia.dart';

import 'languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'id'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEnglish();
      case 'id':
        return LanguageIndonesia();
      default:
        return LanguageIndonesia();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
