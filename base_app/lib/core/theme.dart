import 'package:core/core.dart' show GoogleFonts;
import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.red,
    backgroundColor: Colors.white54,
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    
    textTheme: TextTheme(
      
      bodyText1: GoogleFonts.roboto(color: Colors.black),
      bodyText2: GoogleFonts.roboto(color: Colors.black),
      headline1: GoogleFonts.roboto(color: Colors.black, fontSize: 24),
      headline2: GoogleFonts.roboto(color: Colors.black, fontSize: 22),
      headline3: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
      headline4: GoogleFonts.roboto(color: Colors.black, fontSize: 18),
      headline5: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
      headline6: GoogleFonts.roboto(color: Colors.black, fontSize: 14),
    ),
  );
}

class DarkTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.red,
    backgroundColor: Colors.black54,
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black54,
    textTheme: TextTheme(
      bodyText1: GoogleFonts.roboto(color: Colors.white),
      bodyText2: GoogleFonts.roboto(color: Colors.white),
      headline1: GoogleFonts.roboto(color: Colors.white, fontSize: 24),
      headline2: GoogleFonts.roboto(color: Colors.white, fontSize: 22),
      headline3: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
      headline4: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
      headline5: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
      headline6: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
    ),
  );
}
