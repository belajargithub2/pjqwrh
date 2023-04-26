library deasy_logger;

import 'package:logger/logger.dart';

import 'deasy_log_printer.dart';

class DeasyLoggerUtil {
  static Logger getLogger(String className) => Logger(
    printer: PrefixPrinter(
      DeasyLogPrinterUtil(
        className: className,
        colors: false,
      ),
    ),
  );
}