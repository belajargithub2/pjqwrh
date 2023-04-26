import 'languages.dart';

class LanguageEnglish extends Languages {
  @override
  String get onBoardingTitle1 => "Ease of managing orders";

  @override
  String get onBoardingTitle2 => "Get it all in your hand";

  @override
  String get onBoardingTitle3 => "Explore more in Deasy";

  @override
  String get onBoardingSubtitle1 =>
      "Serves as a centralized application for all Kreditplus inlets, where users can view all orders and their details.";

  @override
  String get onBoardingSubtitle2 =>
      "Get all reports by simply downloading the E-PO (Purchase Order) and E-Invoice, also uploading the BAST File (Handover Minutes)";

  @override
  String get onBoardingSubtitle3 =>
      "As a super admin, create new users, as well as assign roles and features to each user based on their needs.";

  @override
  String get loginDescription => "The dealer management system aims to facilitate payment transactions through Kreditplus.";

  @override
  String get loginForgotPassword => "Forgot password?";

  @override
  String get loginSubmit => "Login";

  @override
  String get loginUsername => "No Handphone / Email";

  @override
  String get loginEmail => "Email";

  @override
  String get loginPassword => "Password";

  @override
  String get enterEmail => "Enter Email";

  @override
  String get enterPassword => "Enter Password";
  

  @override
  String get loginWelcome => "Welcome";

  @override
  String get loginFillAllField => "Please fill in all fields";

  @override
  String get loginInvalidEmail => "Your email / cellphone number is wrong";

  @override
  String get loginInvalidPassword => "Your password is Incorrect";

  @override
  String get loginEmailNotFound => "Your email / cellphone number has not been registered";

  @override
  String get noInternet => "No internet connection";

  @override
  String get error500 => "An error occurred on the server";

  @override
  String get homeNoBAST => "There are no bast to upload at this time.";

  @override
  String get homeNoTransaction => "You currently have no transactions, please try another day.";

  @override
  String get homeTodayTransaction => "Today's Transactions";

  @override
  String get homeWelcome => "Good morning, ";
}
