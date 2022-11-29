import 'package:flutter/material.dart';

import '../foreground/dark_foreground.dart';
import '../foreground/foreground_color_palette.dart';
import '../product/dark_product_color_palette.dart';
import '../product/product_color_palette.dart';
import '../risk/dark_risk_color_palette.dart';
import '../risk/risk_color_palette.dart';
import 'color_palette.dart';

///
/// Color palette definition for Dark theme.
///
class DarkColorPalette implements IColorPalette {
  @override
  IForegroundColorPalette get foreground => DarkForeground();

  @override
  IRiskColorPalette get risk => DarkRiskColorPalette();

  @override
  IProductColorPalette get product => DarkProductColorPalette();

  @override
  MaterialColor get base => const MaterialColor(
        0xff050922,
        {
          50: Color(0xff050922),
          200: Color(0xff24283E),
          400: Color(0xff636779),
          500: Color(0xff9194A3),
          700: Color(0xffDDDEE4),
          900: Color(0xffFAFBFF),
        },
      );

  @override
  MaterialColor get primary => const MaterialColor(
        0xff53BAFF,
        {
          50: Color(0xff0B2054),
          200: Color(0xff1E6ACD),
          400: Color(0xff38A8FF),
          500: Color(0xff53BAFF),
          700: Color(0xffA6E0FF),
          900: Color(0xffEBF8FF),
        },
      );

  @override
  MaterialColor get secondary => const MaterialColor(
        0xff7E80FB,
        {
          50: Color(0xff011367),
          200: Color(0xff2936C4),
          400: Color(0xff5D65F7),
          500: Color(0xff7E80FB),
          700: Color(0xffBDBCFF),
          900: Color(0xffEBEBFF),
        },
      );

  @override
  MaterialColor get tertiary => const MaterialColor(
        0xff4CE6FA,
        {
          50: Color(0xff0E455D),
          200: Color(0xff1FACCE),
          400: Color(0xff37DDF6),
          500: Color(0xff4CE6FA),
          700: Color(0xff8EF3FC),
          900: Color(0xffE6FEFF),
        },
      );

  @override
  MaterialColor get lightGreen => const MaterialColor(
        0xff9CCC65,
        {
          50: Color(0xff33691E),
          200: Color(0xff689F38),
          400: Color(0xff8BC34A),
          500: Color(0xff9CCC65),
          700: Color(0xffC5E1A5),
          900: Color(0xffF1F8E9),
        },
      );

  @override
  MaterialColor get amber => const MaterialColor(
        0xffFFCA28,
        {
          50: Color(0xffFF6F00),
          200: Color(0xffFFA000),
          400: Color(0xffFFC107),
          500: Color(0xffFFCA28),
          700: Color(0xffFFE082),
          900: Color(0xffFFF8E1),
        },
      );

  @override
  MaterialColor get deepOrange => const MaterialColor(
        0xffFF7043,
        {
          50: Color(0xffBF360C),
          200: Color(0xffE64A19),
          400: Color(0xffFF5722),
          500: Color(0xffFF7043),
          700: Color(0xffFFAB91),
          900: Color(0xffFBE9E7),
        },
      );
}
