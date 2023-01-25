import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColorgreen = const Color(0xFF3b9abf);
  static Color primaryColor = const Color(0xFF3b9abf);
  static Color secondColor = const Color(0xFF3b9abf);
  static Color primaryColorDark = const Color(0xFF3b9abf);
  static Color primaryColorLight = const Color(0xffd3e4e5);

  static Color focusColor = const Color(0xFFF6F4F4);
  static Color disable = const Color(0xFFEBEBE4);
  static Color focusColorDark = const Color(0xFFF6F1F1);

  static Color hintColor = const Color(0xFF3b9abf);
  static Color hintColorDark = const Color(0xff013300);

  static Color pendingColor = const Color(0xfffff330);
  static Color dividerColorDark = const Color(0xff9f0954);

  static Color lightThemeColor = const Color(0xffffffff);
  static Color darkThemeColor = const Color(0xFF000000);
  static Color backgroundColor = const Color(0xfff1efef);
  static Color transparentColor = Colors.transparent;
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color redColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color grayColor300 = Colors.grey[300]!;
  static Color boxShadowColorDialog = Colors.black26;
  static const Color backgroundColorCircularLoading = Colors.black26;

  static MaterialColor primarySwatchLightColor = Colors.blue;
  static MaterialColor primarySwatchDarkColor = Colors.blue;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
