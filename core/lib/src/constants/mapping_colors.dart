import 'package:flutter/material.dart';

class ThemeColors {
  static Color get appBarTheme => const Color(0xFFffc72b);
  static Color get blue => const Color(0xFF0e97ff);
  static Color get cardColor => const Color(0xFFCECECE);
  static Color get backgroundColor => const Color(0xFFFFFFFF);
  static Color get scaffoldBackgroundColor => const Color.fromARGB(
        255,
        239,
        240,
        243,
      );
  static Color get dialogBackgroundColor => const Color(0xFFE4E6E9);
  static Color get foregroundColor => const Color(0xFF222E34);
  static Color get iconTheme => const Color(0xff1b262c);
  static Color get bodyText2 => const Color(0xFF1B262C);
  static Color get subtitle2 => const Color(0xff1b262c);

  static MaterialColor get primarySwatch {
    return const MaterialColor(0xFF1b262c, {
      50: Color.fromRGBO(255, 106, 18, .1),
      100: Color.fromRGBO(255, 106, 18, .2),
      200: Color.fromRGBO(255, 106, 18, .3),
      300: Color.fromRGBO(255, 106, 18, .4),
      400: Color.fromRGBO(255, 106, 18, .5),
      500: Color.fromRGBO(255, 106, 18, .6),
      600: Color.fromRGBO(255, 106, 18, .7),
      700: Color.fromRGBO(255, 106, 18, .8),
      800: Color.fromRGBO(255, 106, 18, .9),
      900: Color.fromRGBO(255, 106, 18, 1),
    });
  }
}
