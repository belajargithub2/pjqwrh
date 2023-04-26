import 'package:intl/intl.dart';

extension DeasyDateExtension on DateTime {
  String toFormattedDate({String format = 'dd-MM-yyyy', String? locale}) {
    final DateFormat formatter = DateFormat(format, locale);
    final String formatted = formatter.format(this);
    return formatted;
  }

  DateTime previousYear({required int years}) {
    return DateTime(this.year - years, this.month, this.day);
  }

  DateTime previousMonth({required int months}) {
    return DateTime(this.year, this.month - months, this.day);
  }

  DateTime nextMonth({required int months}) {
    return DateTime(this.year, this.month + months, this.day);
  }

  DateTime previousDay({required int days}) {
    return DateTime(this.year, this.month, this.day - days);
  }

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  DateTime get lastDayOfMonth => month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

}
