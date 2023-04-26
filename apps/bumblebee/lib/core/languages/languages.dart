import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // on boarding.
  String get onBoardingTitle1;

  String get onBoardingTitle2;

  String get onBoardingTitle3;

  String get onBoardingSubtitle1;

  String get onBoardingSubtitle2;

  String get onBoardingSubtitle3;

  //login
  String get loginWelcome;

  String get loginDescription;

  String get loginUsername;

  String get loginForgotPassword;

  String get loginSubmit;

  String get loginEmail;

  String get loginPassword;

  String get enterEmail;

  String get enterPassword;

  // error message
  String get noInternet;

  String get error500;

  String get loginInvalidEmail;

  String get loginInvalidPassword;

  String get loginFillAllField;

  String get loginEmailNotFound;

  // Home page
  String get homeWelcome;

  String get homeNoTransaction;

  String get homeNoBAST;

  String get homeTodayTransaction;
}
