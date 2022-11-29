import 'package:core/core.dart' show GoogleFonts;
import 'package:flutter/material.dart';

class LightTheme {
  static MaterialColor primarySwatch = const MaterialColor(
    0xFFEC6623,
    {},
  );
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFFEC6623),
    // primarySwatch: primarySwatch,
    backgroundColor: const Color(0xFFFFFAF8),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: const Color(0xFFF2EDEB),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFEC6623),
      onPrimary: Color(0xFF0A1631),
      secondary: Color(0xFF0A1631),
      onSecondary: Color(0xFFEC6623),
      error: Colors.red,
      onError: Colors.red,
      background: Color(0xFFFFFAF8),
      onBackground: Color(0xFFF2EDEB),
      surface: Color(0xFFFFFAF8),
      onSurface: Color(0xFFF2EDEB),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(color: Colors.black, fontSize: 12),
      bodyText2: GoogleFonts.montserrat(color: Colors.white, fontSize: 12),
      headline1: GoogleFonts.montserrat(color: Colors.black, fontSize: 28),
      headline2: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
      headline3: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
      headline4: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      headline5: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      headline6: GoogleFonts.montserrat(
        color: const Color(0xFF838587),
        fontWeight: FontWeight.w300,
        fontSize: 8,
      ),
    ),
  );
}

class DarkTheme {
  static MaterialColor primarySwatch = const MaterialColor(
    0xFFEC6623,
    {
      50: Color(0xFFFFFAF8),
    },
  );
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFFEC6623),
    // primarySwatch: primarySwatch,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    backgroundColor: const Color(0xFF0A1631),
    scaffoldBackgroundColor: const Color(0xFFFFFAF8),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFEC6623),
      onPrimary: Color(0xFF0A1631),
      secondary: Color(0xFF0A1631),
      onSecondary: Color(0xFFEC6623),
      error: Colors.red,
      onError: Colors.red,
      background: Color(0xFF2A2A2A),
      onBackground: Colors.white,
      surface: Color(0xFF2A2A2A),
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(color: Colors.white, fontSize: 14),
      bodyText2: GoogleFonts.montserrat(color: Colors.black, fontSize: 14),
      headline1: GoogleFonts.montserrat(color: Colors.white, fontSize: 24),
      headline2: GoogleFonts.montserrat(color: Colors.white, fontSize: 22),
      headline3: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
      headline4: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
      headline5: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
      headline6: GoogleFonts.montserrat(color: Colors.white, fontSize: 14),
    ),
  );
}
