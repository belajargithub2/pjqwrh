import 'dart:ui';

class HexColor extends Color {
  static var statusBarColor = HexColor('FF9A00');
  static var primaryColor = HexColor('FFBC00');

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}