import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'typography_constants.dart';
import 'typography_extension.dart';

///
/// Builder class to construct styles related to Typography.
///
abstract class TypographyBuilder {
  ///
  /// Creates the app default text styles, defined by our UX Team.
  ///
  static AppTextStyle get  buildAppTextStyle {
    return AppTextStyle(
      bodyLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: AppFontWeight.bold.value,
      ),
      bodyMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 14,
        fontWeight: AppFontWeight.regular.value,
      ),
      bodySmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: AppFontWeight.light.value,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 20,
        fontWeight: AppFontWeight.bold.value,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 18,
        fontWeight: AppFontWeight.regular.value,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: AppFontWeight.light.value,
      ),
      displayLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 10,
        fontWeight: AppFontWeight.bold.value,
      ),
      displayMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 8,
        fontWeight: AppFontWeight.regular.value,
      ),
      displaySmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 6,
        fontWeight: AppFontWeight.light.value,
      ),
      headlineLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 28,
        fontWeight: AppFontWeight.bold.value,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 26,
        fontWeight: AppFontWeight.regular.value,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 24,
        fontWeight: AppFontWeight.light.value,
      ),
      labelLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: AppFontWeight.bold.value,
      ),
      labelMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 14,
        fontWeight: AppFontWeight.regular.value,
      ),
      labelSmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: AppFontWeight.light.value,
      ),
    );
  }
}
