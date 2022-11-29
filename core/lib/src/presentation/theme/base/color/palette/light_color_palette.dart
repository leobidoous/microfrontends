import 'package:flutter/material.dart';

import '../foreground/foreground_color_palette.dart';
import '../foreground/light_foreground.dart';
import '../product/light_product_color_palette.dart';
import '../product/product_color_palette.dart';
import '../risk/light_risk_color_palette.dart';
import '../risk/risk_color_palette.dart';
import 'color_palette.dart';

///
/// Color palette definition for Light theme.
///
class LightColorPalette implements IColorPalette {
  @override
  IForegroundColorPalette get foreground => LightForeground();

  @override
  IRiskColorPalette get risk => LightRiskColorPalette();

  @override
  IProductColorPalette get product => LightProductColorPalette();

  @override
  MaterialColor get base => const MaterialColor(
        0xffFAFBFF,
        {
          50: Color(0xffFAFBFF),
          200: Color(0xffDDDEE4),
          400: Color(0xff9194A3),
          500: Color(0xff636779),
          700: Color(0xff24283E),
          900: Color(0xff050922),
        },
      );

  @override
  MaterialColor get primary => const MaterialColor(
        0xff38A8FF,
        {
          50: Color(0xffEBF8FF),
          200: Color(0xffA6E0FF),
          400: Color(0xff53BAFF),
          500: Color(0xff38A8FF),
          700: Color(0xff1E6ACD),
          900: Color(0xff0B2054),
        },
      );

  @override
  MaterialColor get secondary => const MaterialColor(
        0xff5D65F7,
        {
          50: Color(0xffEBEBFF),
          200: Color(0xffBDBCFF),
          400: Color(0xff7E80FB),
          500: Color(0xff5D65F7),
          700: Color(0xff2936C4),
          900: Color(0xff011367),
        },
      );

  @override
  MaterialColor get tertiary => const MaterialColor(
        0xff37DDF6,
        {
          50: Color(0xffE6FEFF),
          200: Color(0xff8EF3FC),
          400: Color(0xff4CE6FA),
          500: Color(0xff37DDF6),
          700: Color(0xff1FACCE),
          900: Color(0xff0E455D),
        },
      );

  @override
  MaterialColor get lightGreen => const MaterialColor(
        0xff8BC34A,
        {
          50: Color(0xffF1F8E9),
          200: Color(0xffC5E1A5),
          400: Color(0xff9CCC65),
          500: Color(0xff8BC34A),
          700: Color(0xff689F38),
          900: Color(0xff33691E),
        },
      );

  @override
  MaterialColor get amber => const MaterialColor(
        0xffFFC107,
        {
          50: Color(0xffFFF8E1),
          200: Color(0xffFFE082),
          400: Color(0xffFFCA28),
          500: Color(0xffFFC107),
          700: Color(0xffFFA000),
          900: Color(0xffFF6F00),
        },
      );

  @override
  MaterialColor get deepOrange => const MaterialColor(
        0xffFF5722,
        {
          50: Color(0xffFBE9E7),
          200: Color(0xffFFAB91),
          400: Color(0xffFF7043),
          500: Color(0xffFF5722),
          700: Color(0xffE64A19),
          900: Color(0xffBF360C),
        },
      );
}
