import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive/responsive_extension.dart';

class AppThemeBase {
  static const int designScreenWidth = 430;
  static const int designScreenHeight = 932;

  static const Color colorPrimaryDarkest = Color(0xFF000000);
  static const Color colorPrimaryDark = Color(0xFF050922);
  static const Color colorSecondaryDarkest = Color(0xFF2B3182);
  static const Color colorSecondaryDark = Color(0xFF3047C7);
  static const Color colorSecondaryDarkMedium = Color(0xFF334fea);
  static const Color colorTertiaryDark = Color(0xFF6E57FF);
  static const Color colorSystemErrorDark = Color(0xFFE23535);
  static Color get colorInactiveSwitchDark =>
      const Color(0xFF9CB1C9).withOpacity(0.7);

  static const Color colorPrimaryMedium = Color(0xFF2D314A);
  static const Color colorPrimaryLight = Color(0xFFCBD0F0);
  static const Color colorPrimaryLightest = Color(0xFFE5EFF8);
  static const Color colorPrimarySuperlight = Color(0xFFFFFFFF);
  static const Color colorSecondaryMedium = Color(0xFF499ED7);
  static const Color colorSecondaryLight = Color(0xFF37DCF6);
  static const Color colorSecondaryLightest = Color(0xFF7ED4FF);
  static const Color colorSecondaryLightmodeSuperlight = Color(0xFFFFFFFF);
  static const Color colorTertiaryMedium = Color(0xFFCBD0F0);
  static const Color colorTertiaryLight = Color(0xFFE8EAFA);
  static const Color colorNeutralLightmodeDarkest = Color(0xFF262626);
  static const Color colorNeutralLightmodeDark = Color(0xFF575756);
  static const Color colorNeutralLightmodeLight = Color(0xFF979797);
  static const Color colorNeutralLightmodeLightest = Color(0xFFDADADA);
  static const Color colorSystemSuccessDefault = Color(0xFF25DDB1);
  static const Color colorSystemErrorDefault = Color(0xFFFF6C6C);
  static const Color colorSystemErrorLight = Color(0xFFFFA5A5);
  static const Color colorFixedIncome = Color(0xff0099FF);
  static const Color colorFunds = Color(0xff3D58F2);
  static const Color colorIconPurple = Color(0xff6F72FB);
  static const Color colorBlueGradientEnd = Color(0xFF221F57);
  static const Color colorPurpleDefault = Color(0xFF3D46F2);
  static const Color colorPurpleSelected = Color(0xFF373FDA);
  static const Color colorBlackBottomGradientEnd = Color(0xFF05092C);

  static const Color colorGraySliderBackground = Color(0xFFC4C5CA);
  static const Color colorBorderCreditCardStandard = Color(0xFF30E6F9);
  static const Color colorBorderCreditCardPlatinum = Color(0xFF808A8E);
  static const Color colorBorderCreditCardBlack = Color(0xFF050607);
  static const Color colorDividerCreditCardStandard = Color(0xFF999CA6);
  static const Color colorDividerCreditCardPlatinum = Color(0xFFFFFFFF);
  static const Color colorDividerCreditCardBlack = Color(0xFF999CA6);
  static const Color colorPurpleLight = Color(0xFFFAFAFF);
  static const Color colorBlueLight = Color(0xFFCBD0F0);
  static const Color colorLinkDefault = Color(0xFF4C6FFD);

  static const LinearGradient grandientMenuMain = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colorPrimaryDark,
      Color(0xFF221F57),
    ],
  );
  static const Color colorBaseBackgroundCreditCardError = Color(0xFF030616);

  static const LinearGradient gradientPrimaryDark = LinearGradient(
    colors: [
      Color(0xFF05092C),
      Color(0xFFFFFFFF),
    ],
  );

  static const SweepGradient gradientSuccessBackground = SweepGradient(
    stops: [0.7, 1],
    colors: <Color>[Color(0xFF221F57), Color(0xFF040714)],
    transform: GradientRotation(math.pi / 1),
    center: Alignment(-1, 1),
  );

  static const LinearGradient gradientPrimaryLight = LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFCBD0F0),
    ],
  );

  static const LinearGradient gradientDestakDark = LinearGradient(
    colors: [
      colorPrimaryDark,
      Color(0xFF6F72FB),
    ],
  );

  static const LinearGradient gradientDestakLight = LinearGradient(
    colors: [
      Color(0xFF499ED7),
      Color(0xFF7B61FF),
    ],
  );

  static const LinearGradient gradientCreditCardStandard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF03071C), Color(0xFF01448C)], // red to yellow
  );

  static const LinearGradient gradientPageBackgroundError = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(5.0, 1.0),
    stops: [
      0.1,
      0.2,
      0.2,
      1.0,
    ],
    colors: [
      colorBaseBackgroundCreditCardError,
      colorPrimaryDark,
      colorPrimaryDark,
      colorSystemErrorDark,
    ],
  );

  static const LinearGradient gradientCreditCardPlatinum = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[Color(0xFFE1E2E2), Color(0xFF7F8B8F)],
  );

  static const LinearGradient gradientCreditCardBlack = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(3.0, 0.0),
    colors: <Color>[Color(0xFF050607), Color(0xFF050607)],
  );

  static const LinearGradient gradientDarkerToDarkStandard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(3.0, 0.0),
    colors: <Color>[Color(0xFF060A23), Color(0xFF007FD3)],
  );

  static Gradient get gradientDarkToDarker => const SweepGradient(
        colors: [
          Color.fromRGBO(232, 234, 250, 0),
          Color.fromRGBO(209, 214, 242, 0.5539),
          Color.fromRGBO(123, 97, 255, 0.7),
          Color.fromRGBO(232, 234, 250, 0),
        ],
        stops: [-0.13, 0.15, 0.72, 0.99],
        startAngle: 3.2,
        center: FractionalOffset(-0.6, 0.68),
        transform: GradientRotation(math.pi / 1.35),
      );

  static Gradient get gradientRedToDark => const SweepGradient(
        colors: [
          Color.fromRGBO(232, 234, 250, 0),
          Color.fromRGBO(209, 214, 242, 0.79),
          Color(0xFFE23535),
          Color.fromRGBO(232, 234, 250, 0),
        ],
        stops: [0.0, 0.57, 0.72, 0.99],
        startAngle: 2.5,
        center: FractionalOffset(-0.6, 0.8),
        transform: GradientRotation(math.pi / 1.23),
      );
  static const Color colorBaseBackgroundStandard = Color(0xFF060A23);

  static const LinearGradient gradientBackgroundStandard = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment(0.0, 6.0),
    colors: <Color>[
      Color(0xFF060A23),
      Color(0xFF007FD3),
    ],
  );
  static const Color colorBaseBackgroundPlatinum = Color(0xFF808A8E);

  static const LinearGradient gradientBackgroundPlatinum = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFF808A8E),
      Color(0xFF9EA5A9),
    ],
  );
  static const Color colorBaseBackgroundBlack = Color(0xFF000000);

  static const LinearGradient gradientBackgroundBlack = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFF0B0B0B),
      Color(0xFF272727),
    ],
  );
  static const Color progressIndicatorBackground = Color(0xffC4C4C4);

  static const LinearGradient gradientBackgroundStandardPreviewCard =
      LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment(0.0, -1.0),
    colors: <Color>[
      Color(0xFF060A23),
      Color(0xFF004A7B),
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF)
    ],
  );

  static const LinearGradient gradientBackgroundPlatinumPreviewCard =
      LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment(0.0, -1.0),
    colors: <Color>[
      Color(0xFF808A8E),
      Color(0xFFA1A7A9),
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
  );

  static const LinearGradient gradientBackgroundBlackPreviewCard =
      LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment(0.0, -1.0),
    colors: <Color>[
      Color(0xFF000000),
      Color(0xFF141414),
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
  );
  static String get fontFamily => GoogleFonts.montserrat.toString();
  
  static double get lineHeightTight => 0.75;
  static double get lineHeightRegular => 1;
  static double get lineHeightMedium => 1.25;
  static double get lineHeightDistant => 1.5;
  static double get lineHeightSuperDistant => 2;
  
  static double get buttonHeight => 38.responsiveHeight;
  static double get buttonHeightSM => 28.responsiveHeight;
  static double get buttonHeightMD => 40.responsiveHeight;
  static double get buttonHeightLG => 56.responsiveHeight;

  static BorderRadius get borderRadiusNone => BorderRadius.zero;
  static BorderRadius get borderRadiusSM => BorderRadius.circular(8);
  static BorderRadius get borderRadiusMD => BorderRadius.circular(16);
  static BorderRadius get borderRadiusLG => BorderRadius.circular(24);

  static double get borderWidthSM => 1.5.responsiveWidth;
  static double get borderWidthXS => 1.responsiveWidth;

  static double get opacityLevelSemiopaque => 0.8;
  static double get opacityLevelIntense => 0.64;
  static double get opacityLevelMedium => 0.32;
  static double get opacityLevelLight => 0.16;
  static double get opacityLevelSemiTransparent => 0.08;
  
  static BoxShadow get shadowLightmodeLevel0 => const BoxShadow(
        blurRadius: 16,
        offset: Offset(0, -8),
      );
  static BoxShadow get shadowLightmodeLevel1 => const BoxShadow(
        blurRadius: 16,
        offset: Offset(0, 4),
      );
  static BoxShadow get shadowLightmodeLevel2 => const BoxShadow(
        blurRadius: 24,
        offset: Offset(0, 8),
      );
  static BoxShadow get shadowLightmodeLevel3 => const BoxShadow(
        blurRadius: 32,
        offset: Offset(0, 16),
      );
  static BoxShadow get shadowLightmodeLevel4 => const BoxShadow(
        blurRadius: 18,
        offset: Offset(0, 16),
      );
  static BoxShadow get shadowLightmodeLevel5 => const BoxShadow(
        blurRadius: 8,
        offset: Offset(2, 0),
      );
  
  static double get appBarHeight => 60.responsiveHeight;
  static double get customRadioCircleSize => 15.fontSize;
  static double get disclaimerIconSize => 18.fontSize;
}
