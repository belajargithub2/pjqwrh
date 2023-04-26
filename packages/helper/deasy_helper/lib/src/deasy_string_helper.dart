import 'dart:math';

class DeasyStringHelper {
  static String getRandomString(
          {required int length,
          String chars =
              "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"}) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
}
