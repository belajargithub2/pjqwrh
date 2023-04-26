import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DeasyStringExtension on String? {
  static const _locale = 'id';

  String _decimalCurrencyFormatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));

  String _simpleCurrencyFormatNumber(String s) => NumberFormat.simpleCurrency(locale: _locale).format(int.parse(s));

  String toSimpleCurrency() {
    return _simpleCurrencyFormatNumber(this!);
  }

  int toInt() {
    return int.parse(this!);
  }

  String toCurrency() {
    return "Rp ${_decimalCurrencyFormatNumber(this!.replaceAll('.', ''))}";
  }

  // ex: 2547993.94 -> Rp 2.547.993,94 or 6051000 -> Rp 6.051.000,00
  String toRupiah() {
    if (this!.contains('.')) {
      var split = this!.split('.');
      var decimal = split[1];
      var integer = split[0];
      return "Rp ${_decimalCurrencyFormatNumber(integer.replaceAll('.', ''))},${decimal.getStringAfterDot()}";
    } else {
      return "Rp ${_decimalCurrencyFormatNumber(this!.replaceAll('.', ''))},00";
    }
  }

  String toRupiahNoDecimal() {
    if (this!.contains('.')) {
      var split = this!.split('.');
      var decimal = split[1];
      var integer = split[0];
      return "Rp ${_decimalCurrencyFormatNumber(integer.replaceAll('.', ''))}";
    } else {
      return "Rp ${_decimalCurrencyFormatNumber(this!.replaceAll('.', ''))}";
    }
  }

  String getStringAfterDot() {
    return this!.split('.').last == '0' ? '00' : this!.split('.').last;
  }

  String toDecimalFormat() {
    return "${_decimalCurrencyFormatNumber(this!.replaceAll('.', ''))}";
  }

  String toCleanString() {
    return "${this!.replaceAll('.', '')}";
  }

  String toFormattedDate({String format = 'dd-MM-yyyy',
    String locale = 'id', String defaultReturn = '-', bool convertToLocal = true}) {
    try {
      final DateTime time = convertToLocal ?
        DateTime.parse(this!).toLocal() : DateTime.parse(this!);
      final DateFormat formatter = convertToLocal ? DateFormat(format, locale) : DateFormat(format);
      final String formatted = formatter.format(time);
      return formatted;
    } catch (e) {
      return defaultReturn;
    }
  }

  String toDashIfNull() {
    if (this == null) {
      return "-";
    } else {
      return this!;
    }
  }

  String toEmptyIfNull() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }

  String toNnA() {
    if (this!.isEmpty) {
      return "N/A";
    } else {
      return this!;
    }
  }

  bool isEqualIgnoreCase(String value) {
    return this?.toEmptyIfNull().toLowerCase() == value.toEmptyIfNull().toLowerCase();
  }

  bool isContainIgnoreCase(String value) {
    return (this?.toEmptyIfNull().toLowerCase().contains(value.toEmptyIfNull().toLowerCase()))!;
  }

  bool isPasswordFormatCorrect() {
    return this!.contains(RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$'));
  }

  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Checks if string is a valid name.
  bool isName() =>
      GetUtils.hasMatch(this, r'^[a-zA-Z0-9]+(([a-zA-Z0-9 ])?[a-zA-Z0-9]*)*$');

  // Check if string contain alphanumeric and whitespace
  bool isUserName() => GetUtils.hasMatch(this, r'^[a-zA-Z0-9 ]+$');

  /// Checks if string is a valid url.
  bool urlValidation() {
    return GetUtils.hasMatch(this,
        r"(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?");
  }

  bool isAlphanumeric() {
    bool hasAlphabet = this!.contains(RegExp(r'[A-Za-z]'));
    bool hasDigits = this!.contains(RegExp(r'[0-9]'));

    return hasAlphabet & hasDigits;
  }

  /// Check if string is phone number.
  bool isIdPhoneNumber() {
    return GetUtils.hasMatch(this, r'^[08]{2}?[0-9]{8,12}$');
  }

  bool isEmailAddress() {
    return GetUtils.hasMatch(this, r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  }

  bool isPasswordStrength() {
    return GetUtils.hasMatch(this, r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$');
  }

  String? emailValidator({
    required String msgEmailCantBeEmpty,
    required String msgEmailNotValid
  }) {
    if (this!.isEmpty) {
      return msgEmailCantBeEmpty;
    } else if (this!.isNotEmpty && !this!.isEmailAddress()) {
      return msgEmailNotValid;
    } else {
      return null;
    }
  }

  String? supplierIdValidator({
    required String msgSupplierIdEmpty,
    required String msgSupplierIdSuggestion
  }) {
    if (this!.isBlank!) {
      return msgSupplierIdEmpty;
    } else if (!this!.isAlphanumeric()) {
      return msgSupplierIdSuggestion;
    }
    return null;
  }

  String? userNameValidator({
    required String msgUserNameCantBeEmpty,
    required String msgUserNameCantContainSpecialChar
  }) {
    if (this!.isBlank!) {
      return msgUserNameCantBeEmpty;
    } else if (!this!.isUserName()) {
      return msgUserNameCantContainSpecialChar;
    }
    return null;
  }

  String? nameValidator({
    required String msgNameCantBeEmpty,
    required String msgNameMaxLength,
    required String msgNameCantContainSpecialChar
  }) {
    if (this!.isBlank!) {
      return msgNameCantBeEmpty;
    } else if (this!.length > 50) {
      return msgNameMaxLength;
    } else if (!this!.isName()) {
      return msgNameCantContainSpecialChar;
    }
    return null;
  }

  String? phoneValidator({
    String? msgPhoneCantBeEmpty,
    required String msgPhoneNotValid
  }) {
    if (this!.isBlank! && msgPhoneCantBeEmpty != null) {
      return msgPhoneCantBeEmpty;
    } else if (!this!.isBlank! && !this!.isIdPhoneNumber()) {
      return msgPhoneNotValid;
    }
    return null;
  }

  DateTime get toDate => DateTime.parse(this!);

}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}