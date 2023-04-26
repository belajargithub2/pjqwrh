import 'package:deasy_color/deasy_color.dart';
import 'package:flutter/material.dart';

class AppConfig {
  Color appBarColor = DeasyColor.neutral000;
  Color statusBarColor = DeasyColor.kpBlue500;
  Color buttonPrimaryColor = DeasyColor.kpYellow500;
  Color buttonTextPrimaryColor = DeasyColor.neutral000;
  Color buttonSecondaryColor = DeasyColor.neutral000;
  Color buttonTextSecondaryColor = DeasyColor.kpYellow500;
  Color textButtonOutlineTextColor = DeasyColor.kpYellow500;
  Color textButtonTextColor = DeasyColor.neutral800;
  Color iconButtonColor = DeasyColor.neutral000;
  Color iconButtonTextColor = DeasyColor.kpYellow500;
  Color iconButtonActiveColor = DeasyColor.neutral000;
  Color iconButtonInactiveTextColor = DeasyColor.neutral200;
  Color stepperActiveColor = DeasyColor.dms0099FF;
  Color stepperInactiveColor = DeasyColor.neutral200;
  Color formTitleColor = DeasyColor.neutral800;

  /// private constructor
  AppConfig._();

  /// the one and only instance of this singleton
  static final instance = AppConfig._();

  fromJson(Map json) {
    appBarColor = json['app_bar_color'] != null
        ? DeasyHexColor(json['app_bar_color'])
        : appBarColor;
    statusBarColor = json['status_bar_color'] != null
        ? DeasyHexColor(json['status_bar_color'])
        : statusBarColor;
    buttonPrimaryColor = json['button_primary_color'] != null
        ? DeasyHexColor(json['button_primary_color'])
        : buttonPrimaryColor;
    buttonTextPrimaryColor = json['button_text_primary_color'] != null
        ? DeasyHexColor(json['button_text_primary_color'])
        : buttonTextPrimaryColor;
    buttonSecondaryColor = json['button_secondary_color'] != null
        ? DeasyHexColor(json['button_secondary_color'])
        : buttonSecondaryColor;
    buttonTextSecondaryColor = json['button_text_secondary_color'] != null
        ? DeasyHexColor(json['button_text_secondary_color'])
        : buttonTextSecondaryColor;
    textButtonOutlineTextColor = json['text_button_outline_text_color'] != null
        ? DeasyHexColor(json['text_button_outline_text_color'])
        : textButtonOutlineTextColor;
    textButtonTextColor = json['text_button_text_color'] != null
        ? DeasyHexColor(json['text_button_text_color'])
        : textButtonTextColor;
    iconButtonColor = json['icon_button_color'] != null
        ? DeasyHexColor(json['icon_button_color'])
        : iconButtonColor;
    iconButtonTextColor = json['icon_button_text_color'] != null
        ? DeasyHexColor(json['icon_button_text_color'])
        : iconButtonTextColor;
    iconButtonActiveColor = json['icon_button_active_color'] != null
        ? DeasyHexColor(json['icon_button_active_color'])
        : iconButtonActiveColor;
    iconButtonInactiveTextColor = json['icon_button_inactive_text_color'] != null
        ? DeasyHexColor(json['icon_button_inactive_text_color'])
        : iconButtonInactiveTextColor;
    stepperActiveColor = json['stepper_active_color'] != null
        ? DeasyHexColor(json['stepper_active_color'])
        : stepperActiveColor;
    stepperInactiveColor = json['stepper_inactive_color'] != null
        ? DeasyHexColor(json['stepper_inactive_color'])
        : stepperInactiveColor;
    formTitleColor = json['form_title_color'] != null
        ? DeasyHexColor(json['form_title_color'])
        : formTitleColor;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_bar_color'] = appBarColor;
    data['status_bar_color'] = statusBarColor;
    data['button_primary_color'] = buttonPrimaryColor;
    data['button_text_primary_color'] = buttonTextPrimaryColor;
    data['button_secondary_color'] = buttonSecondaryColor;
    data['button_text_secondary_color'] = buttonTextSecondaryColor;
    data['text_button_outline_text_color'] = textButtonOutlineTextColor;
    data['text_button_text_color'] = textButtonTextColor;
    data['icon_button_color'] = iconButtonColor;
    data['icon_button_text_color'] = iconButtonTextColor;
    data['icon_button_active_color'] = iconButtonActiveColor;
    data['icon_button_inactive_text_color'] = iconButtonInactiveTextColor;
    data['stepper_active_color'] = stepperActiveColor;
    data['stepper_inactive_color'] = stepperInactiveColor;
    data['form_title_color'] = formTitleColor;
    return data;
  }
}
