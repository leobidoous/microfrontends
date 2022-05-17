import 'package:core/core.dart' show ThemeColors, GoogleFonts;
import 'package:flutter/material.dart';


class LightTheme {
  static final ThemeData theme = ThemeData(
    primarySwatch: ThemeColors.primarySwatch,
    backgroundColor: ThemeColors.backgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeColors.blue,
    ),
    cardColor: ThemeColors.cardColor,
    appBarTheme: AppBarTheme(
      color: ThemeColors.appBarTheme,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 17,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(
          ThemeColors.foregroundColor,
        ),
        overlayColor: MaterialStateProperty.all(
          ThemeColors.primarySwatch.shade100,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: ThemeColors.iconTheme),
    textTheme: TextTheme(
      headline1: GoogleFonts.roboto(color: Colors.black, fontSize: 24),
      headline2: GoogleFonts.roboto(color: Colors.black, fontSize: 22),
      headline3: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
      headline4: GoogleFonts.roboto(color: Colors.black, fontSize: 18),
      headline5: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
      headline6: GoogleFonts.roboto(color: Colors.black, fontSize: 14),
    ),
  );
}
