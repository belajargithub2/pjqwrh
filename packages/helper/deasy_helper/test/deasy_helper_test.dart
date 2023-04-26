import 'package:flutter_test/flutter_test.dart';

import 'package:intl/date_symbol_data_local.dart';

import '../lib/deasy_helper.dart';

void main() {
  group('Date Extension', () {
    test('convert string to formatted date', () async {
      //arrange
      String dateFormat = "dd-MM-yyyy";
      DateTime dateTime = DateTime(2023, 01, 10);

      //act
      final result = dateTime.toFormattedDate(format: dateFormat);

      //assert
      expect(result, '10-01-2023');
    });

    test('get previous year', () async {
      //arrange
      DateTime dateTime = DateTime(2023, 01, 10);

      //act
      final result = dateTime.previousYear(years: 3);

      //assert
      expect(result, DateTime(2020, 01, 10));
    });

    test('get previous month', () async {
      //arrange
      DateTime dateTime = DateTime(2023, 10, 10);

      //act
      final result = dateTime.previousMonth(months: 1);

      //assert
      expect(result, DateTime(2023, 9, 10));
    });

    test('get previous day', () async {
      //arrange
      DateTime dateTime = DateTime(2023, 10, 10);

      //act
      final result = dateTime.previousDay(days: 5);

      //assert
      expect(result, DateTime(2023, 10, 5));
    });

    test('get first day of month', () async {
      //arrange
      DateTime dateTime = DateTime(2023, 10, 10);

      //act
      final result = dateTime.firstDayOfMonth;

      //assert
      expect(result, DateTime(2023, 10, 01));
    });

    test('get last day of month', () async {
      //arrange
      DateTime dateTime = DateTime(2023, 10, 10);

      //act
      final result = dateTime.lastDayOfMonth;

      //assert
      expect(result, DateTime(2023, 10, 31));
    });
  });

  group('String Extension', () {
    test('convert string to simple currency', () async {
      //arrange
      String numString = "150000";

      //act
      final result = numString.toSimpleCurrency();

      //assert
      expect(result, "Rp150.000,00");
    });

    test('convert string to integer', () async {
      //arrange
      String numString = "150000";

      //act
      final result = numString.toInt();

      //assert
      expect(result, 150000);
    });

    test('convert string to currency', () async {
      //arrange
      String numString = "150000";

      //act
      final result = numString.toCurrency();

      //assert
      expect(result, "Rp 150.000");
    });

    test('convert string to rupiah', () async {
      //arrange
      String numString = "150000";

      //act
      final result = numString.toRupiah();

      //assert
      expect(result, "Rp 150.000,00");
    });

    test('get string after dot of non 0 string last char', () async {
      //arrange
      String numString = "150000.12";

      //act
      final result = numString.getStringAfterDot();

      //assert
      expect(result, "12");
    });

    test('get string after dot of 0 string last char', () async {
      //arrange
      String numString = "150000.0";

      //act
      final result = numString.getStringAfterDot();

      //assert
      expect(result, "00");
    });

    test('convert string to decimal format', () async {
      //arrange
      String numString = "150000";

      //act
      final result = numString.toDecimalFormat();

      //assert
      expect(result, "150.000");
    });

    test('convert string to clean string without dot', () async {
      //arrange
      String numString = "150.000";

      //act
      final result = numString.toCleanString();

      //assert
      expect(result, "150000");
    });

    test('convert string to formatted date with specific locale', () async {
      //arrange
      initializeDateFormatting();
      String dateString = "${DateTime(2023, 01, 10)}";

      //act
      final result = dateString.toFormattedDate(format: "dd MMMM yyyy", locale: "id", convertToLocal: false);

      //assert
      expect(result, "10 Januari 2023");
    });

    test('convert string to dash if null with null string', () async {
      //arrange
      String? sampleString;

      //act
      final result = sampleString.toDashIfNull();

      //assert
      expect(result, "-");
    });

    test('convert string to dash if null with not null string', () async {
      //arrange
      String sampleString = "test";

      //act
      final result = sampleString.toDashIfNull();

      //assert
      expect(result, "test");
    });

    test('convert string to empty if null with null string', () async {
      //arrange
      String? sampleString;

      //act
      final result = sampleString.toEmptyIfNull();

      //assert
      expect(result, "");
    });

    test('convert string to empty if null with not null string', () async {
      //arrange
      String? sampleString = "test";

      //act
      final result = sampleString.toEmptyIfNull();

      //assert
      expect(result, "test");
    });

    test('convert string to N/A if string empty', () async {
      //arrange
      String sampleString = "";

      //act
      final result = sampleString.toNnA();

      //assert
      expect(result, "N/A");
    });

    test('convert string to N/A if string is not empty', () async {
      //arrange
      String sampleString = "test";

      //act
      final result = sampleString.toNnA();

      //assert
      expect(result, "test");
    });

    test('check if string is equal ignoring letter case with same text', () async {
      //arrange
      String sampleString1 = "test";
      String sampleString2 = "test";

      //act
      final result = sampleString1.isEqualIgnoreCase(sampleString2);

      //assert
      expect(result, true);
    });

    test('check if string is equal ignoring letter case with different text', () async {
      //arrange
      String sampleString1 = "test";
      String sampleString2 = "testing";

      //act
      final result = sampleString1.isEqualIgnoreCase(sampleString2);

      //assert
      expect(result, false);
    });

    test('check if string is contain another string ignoring letter case with containing text', () async {
      //arrange
      String sampleString1 = "testing";
      String sampleString2 = "test";

      //act
      final result = sampleString1.isContainIgnoreCase(sampleString2);

      //assert
      expect(result, true);
    });

    test('check if string is contain another string ignoring letter case without containing text', () async {
      //arrange
      String sampleString1 = "sample";
      String sampleString2 = "test";

      //act
      final result = sampleString1.isContainIgnoreCase(sampleString2);

      //assert
      expect(result, false);
    });

    test('check if password format is correct with valid password', () async {
      //arrange
      String password = "Kpvendor12#";

      //act
      final result = password.isPasswordFormatCorrect();

      //assert
      expect(result, true);
    });

    test('check if password format is correct with valid password', () async {
      //arrange
      String password = "kpvendor12";

      //act
      final result = password.isPasswordFormatCorrect();

      //assert
      expect(result, false);
    });

    test('check is not null and empty with not empty variable', () async {
      //arrange
      String sample = "test";

      //act
      final result = sample.isNotNullAndNotEmpty;

      //assert
      expect(result, true);
    });

    test('check is not null and empty with empty variable', () async {
      //arrange
      String sample = "";

      //act
      final result = sample.isNotNullAndNotEmpty;

      //assert
      expect(result, false);
    });

    test('check is not null and empty with null variable', () async {
      //arrange
      String? sample;

      //act
      final result = sample.isNotNullAndNotEmpty;

      //assert
      expect(result, false);
    });

    test('check is not null and empty with not null variable', () async {
      //arrange
      String sample = "test";

      //act
      final result = sample.isNotNullAndNotEmpty;

      //assert
      expect(result, true);
    });

    test('check is null or empty with not empty variable', () async {
      //arrange
      String sample = "test";

      //act
      final result = sample.isNullOrEmpty;

      //assert
      expect(result, false);
    });

    test('check is null or empty with empty variable', () async {
      //arrange
      String sample = "";

      //act
      final result = sample.isNullOrEmpty;

      //assert
      expect(result, true);
    });

    test('check is null or empty with null variable', () async {
      //arrange
      String? sample;

      //act
      final result = sample.isNullOrEmpty;

      //assert
      expect(result, true);
    });

    test('check is null or empty with not null variable', () async {
      //arrange
      String? sample = "test";

      //act
      final result = sample.isNullOrEmpty;

      //assert
      expect(result, false);
    });

    test('check is name with valid name', () async {
      //arrange
      String name = "John Doe";

      //act
      final result = name.isName();

      //assert
      expect(result, true);
    });

    test('check is name with invalid name', () async {
      //arrange
      String name = "P";

      //act
      final result = name.isName();

      //assert
      expect(result, false);
    });

    test('check is username with valid username', () async {
      //arrange
      String userName = "John Doe";

      //act
      final result = userName.isUserName();

      //assert
      expect(result, true);
    });

    test('check is username with invalid username', () async {
      //arrange
      String userName = "John Doe!";

      //act
      final result = userName.isUserName();

      //assert
      expect(result, false);
    });

    test('check is url valid with valid url', () async {
      //arrange
      String url = "https://google.com";

      //act
      final result = url.urlValidation();

      //assert
      expect(result, true);
    });

    test('check is url valid with invalid url', () async {
      //arrange
      String url = "google.com";

      //act
      final result = url.urlValidation();

      //assert
      expect(result, false);
    });

    test('check is alphanumeric with valid alphanumeric', () async {
      //arrange
      String alphanumeric = "TEST123";

      //act
      final result = alphanumeric.isAlphanumeric();

      //assert
      expect(result, true);
    });

    test('check is alphanumeric with invalid alphanumeric', () async {
      //arrange
      String alphanumeric = "test";

      //act
      final result = alphanumeric.isAlphanumeric();

      //assert
      expect(result, false);
    });

    test('check is alphanumeric with invalid alphanumeric', () async {
      //arrange
      String alphanumeric = "test";

      //act
      final result = alphanumeric.isAlphanumeric();

      //assert
      expect(result, false);
    });

    test('check is phone number with valid phone number', () async {
      //arrange
      String phoneNumber = "081234567890";

      //act
      final result = phoneNumber.isIdPhoneNumber();

      //assert
      expect(result, true);
    });

    test('check is phone number with invalid phone number', () async {
      //arrange
      String phoneNumber = "1234567890";

      //act
      final result = phoneNumber.isIdPhoneNumber();

      //assert
      expect(result, false);
    });

    test('check is email address with valid email address', () async {
      //arrange
      String email = "test@email.com";

      //act
      final result = email.isEmailAddress();

      //assert
      expect(result, true);
    });

    test('check is email address with invalid email address', () async {
      //arrange
      String email = "test-email.com";

      //act
      final result = email.isEmailAddress();

      //assert
      expect(result, false);
    });

    test('check password strength with strong password', () async {
      //arrange
      String password = "Kpvendor12#";

      //act
      final result = password.isPasswordStrength();

      //assert
      expect(result, true);
    });

    test('check password strengt with weak password', () async {
      //arrange
      String password = "kpvendor12";

      //act
      final result = password.isPasswordStrength();

      //assert
      expect(result, false);
    });

    test('check is email valid with valid email', () async {
      //arrange
      String email = "test@email.com";

      //act
      final result = email.emailValidator(
        msgEmailCantBeEmpty: "email cant be empty",
        msgEmailNotValid: "email is not valid"
      );

      //assert
      expect(result, null);
    });

    test('check is email valid with invalid email', () async {
      //arrange
      String email = "test-gmail.com";

      //act
      final result = email.emailValidator(
        msgEmailCantBeEmpty: "email cant be empty",
        msgEmailNotValid: "email is not valid"
      );

      //assert
      expect(result, "email is not valid");
    });

    test('check is email valid with empty email', () async {
      //arrange
      String email = "";

      //act
      final result = email.emailValidator(
        msgEmailCantBeEmpty: "email cant be empty",
        msgEmailNotValid: "email is not valid"
      );

      //assert
      expect(result, "email cant be empty");
    });

    test('check is supplier id valid with valid supplier id', () async {
      //arrange
      String supplierId = "SUP123";

      //act
      final result = supplierId.supplierIdValidator(
        msgSupplierIdEmpty: "supplier id cant be empty",
        msgSupplierIdSuggestion: "supplier id must be alphanumeric"
      );

      //assert
      expect(result, null);
    });

    test('check is supplier id valid with empty supplier id', () async {
      //arrange
      String supplierId = "";

      //act
      final result = supplierId.supplierIdValidator(
        msgSupplierIdEmpty: "supplier id cant be empty",
        msgSupplierIdSuggestion: "supplier id must be alphanumeric"
      );

      //assert
      expect(result, "supplier id cant be empty");
    });

    test('check is supplier id valid with invalid supplier id', () async {
      //arrange
      String supplierId = "123456";

      //act
      final result = supplierId.supplierIdValidator(
        msgSupplierIdEmpty: "supplier id cant be empty",
        msgSupplierIdSuggestion: "supplier id must be alphanumeric"
      );

      //assert
      expect(result, "supplier id must be alphanumeric");
    });

    test('check is name valid with valid name', () async {
      //arrange
      String name = "John Doe";

      //act
      final result = name.userNameValidator(
        msgUserNameCantBeEmpty: "name cant be empty",
        msgUserNameCantContainSpecialChar: "name cant contain special char"
      );

      //assert
      expect(result, null);
    });

    test('check is name valid with empty name', () async {
      //arrange
      String name = "";

      //act
      final result = name.userNameValidator(
        msgUserNameCantBeEmpty: "name cant be empty",
        msgUserNameCantContainSpecialChar: "name cant contain special char"
      );

      //assert
      expect(result, "name cant be empty");
    });

    test('check is name valid with invalid name', () async {
      //arrange
      String name = "John Doe12#";

      //act
      final result = name.userNameValidator(
        msgUserNameCantBeEmpty: "name cant be empty",
        msgUserNameCantContainSpecialChar: "name cant contain special char"
      );

      //assert
      expect(result, "name cant contain special char");
    });

    test('generate random string with 5 character', () async {
      //arrange
      String sampleChars = "abcde";

      //act
      final result = DeasyStringHelper.getRandomString(length: 5, chars: sampleChars);

      //assert
      expect(result.length, 5);
      expect(
        (
          result.contains('a') || result.contains('b') ||
          result.contains('c') || result.contains('d') ||
          result.contains('e')
        ),
        true
      );
    });
  });
}
