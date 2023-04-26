abstract class DateConstant {
  static String get dateFormat => 'dd/MM/yyyy';

  static String get yearFormat => 'yyyy';

  static String get dateFormat2 => 'dd MMMM yyyy';

  static String get dateFormat3 => 'dd-MM-yyyy HH:mm:ss';

  static String get dateFormat4 => 'dd MMM yyyy';

  static String get dateFormat5 => 'yyyy-MM-dd';

  static String get dateFormat6 => 'yyyy-MM-dd HH:mm';

  static String get dateFormat7 => 'dd MMM yyyy, HH:mm:ss';

  static String get dateFormatddMMyyWithoutDash => 'ddMMyy';

  static String get hourFormat => 'HH:mm';

  static String get dayFormat => 'EEEE';

  static DateTime get getDateNow => DateTime.now();

  static DateTime get getFirstDate => DateTime(1950);

  static DateTime get getEndDate =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  static String get localId => 'id';

  static String get dateFormatISO8601 => "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static String get dateFormatRFC3339 => "yyyy-MM-dd'T'HH:mm:ss'Z'";

}
