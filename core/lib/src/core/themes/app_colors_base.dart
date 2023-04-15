import 'package:flutter/material.dart';

class AppColorsBase {
  ///
  /// Custom color genpag
  ///
  ///
  static Color get primary7Color => const Color(0xFF5542BE);
  static Color get buttonColor => const Color(0xFF531DAB);
  static Color get textButtonColor => const Color(0xFF6D54FC);
  static Color get primary1Color => const Color(0xFFF4EDFF);
  static Color get genpagAccentColor => const Color(0xFF0cbab4);
  static Color get genpagAppBarColor => Colors.white24;
  static Color get genPurpleBackgroundColor => const Color(0xFFF4EDFF);
  static Color get genLightPurpleColor => const Color(0xFF9038FF);
  static Color get genPurpleColor => const Color(0xFF531DAB);
  static Color get genDarkPurpleColor => const Color(0xFF2F1155);
  static Color get genGreyColor => const Color(0xFF4F4F4F);
  static Color get genDarkGreyColor => const Color(0xFF5D5B65);
  static Color get genBottomBarColor => const Color(0xFF391085);
  static Color get genDarkYellowColor => const Color(0xFF5B4010);
  static Color get genLightYellowColor => const Color(0xFFFAEDD4);
  static Color get genLightRedColor => const Color(0xFFFFCED0);
  static Color get primary10Color => const Color(0xFF1A142A);

  static MaterialColor get genpagColor =>
      MaterialColor(0xFF5542BE, <int, Color>{
        50: primary7Color,
        100: primary7Color,
        200: primary7Color,
        300: primary7Color,
        400: primary7Color,
        500: primary7Color,
        600: primary7Color,
        700: primary7Color,
        800: primary7Color,
        900: primary7Color
      });

  static MaterialColor get genpagGreyColor =>
      const MaterialColor(0xFFd0dce8, <int, Color>{
        50: Color(0xFFd0dce8),
        100: Color(0xFFd0dce8),
        200: Color(0xFFd0dce8),
        300: Color(0xFFd0dce8),
        400: Color(0xFFd0dce8),
        500: Color(0xFFd0dce8),
        600: Color(0xFFd0dce8),
        700: Color(0xFFd0dce8),
        800: Color(0xFFd0dce8),
        900: Color(0xFFd0dce8)
      });

  ///
  /// Solid color system
  /// consists of solid colors, without transparency
  ///
  /// used for main solid colors
  static Color get kPrimaryDark => const Color(0xFF161849);
  static Color get kAccent => const Color(0xFF62e1fc);
  static Color get kSecondary => const Color(0xFFf34d77);
  static Color get kSuccess => const Color(0xFF4aa740);
  static Color get kSuccessLight => const Color(0xFFe6f4e9);
  static Color get kWarning => const Color(0xFFff8212);
  static Color get kWarningLight => const Color(0xFFffecdc);
  static Color get kInfo => const Color(0xFF3eacfc);
  static Color get kInfoLight => const Color(0xFFe8f0fd);
  static Color get kDanger => const Color(0xFFf64a4a);
  static Color get kDangerLight => const Color(0xFFfce8e6);
  static Color get kWhite => const Color(0xFFffffff);
  static Color get kGray => const Color(0xFFc2c7cf);
  static Color get kBlack => const Color(0xFF000000);
  static Color get reddd => const Color(0xFFD61328);
  static Color get errorColor => const Color(0xFFD83232);
  static Color get greenzin => const Color(0xFF34AA44);

  ///
  /// Alpha color system
  /// consists of light colors, with transparency
  ///
  /// generally used for shadows
  static Color get kPrimaryDarkShadow => const Color.fromRGBO(22, 24, 73, 0.2);
  static Color get kWarningShadow => const Color.fromRGBO(255, 130, 18, 0.45);
  static Color get kSuccessShadow => const Color.fromRGBO(74, 167, 64, 0.45);
  static Color get kDangerShadow => const Color.fromRGBO(246, 74, 74, 0.45);
  static Color get kInfoShadow => const Color.fromRGBO(62, 172, 252, 0.45);

  // Card colors
  static Color get kTicketColor => const Color(0xFFFAFAFA);

  // Background colors
  static Color get kContainerColor => const Color(0xFFE7E3FF);
  static Color get kSecondaryColor => const Color(0xFFDDA004);


  

  static Color get grey0 => const Color(0xFFCCCED0);
  static Color get grey1 => const Color(0xFFe1f2f9);
  static Color get grey2 => const Color(0xFFFAFAFA);
  static Color get grey3 => const Color(0xFFDBDBDB);
  static Color get grey4 => const Color(0xFF7A828A);
  static Color get grey5 => const Color(0xFF3E424F);
  static Color get grey6 => const Color(0xFF777777);
  static Color get grey7 => const Color(0xFFB9B9B9);
  static Color get grey8 => const Color(0xFF808080);
  static Color get grey9 => const Color(0xFF212121);
  static Color get grey10 => const Color(0xFF353535);
  static Color get grey11 => const Color(0xFF828282);
  static Color get grey12 => const Color(0xFFDBDBDB);
  static Color get grey19 => const Color(0xFF4E4B59);

  static Color get neutrla0 => const Color(0xFFFCFCFC);
  static Color get neutrla1 => const Color(0xFFF5F5F5);
  static Color get neutrla2 => const Color(0xFFF1F1F1);
  static Color get neutrla3 => const Color(0xFFC9C9C9);
  static Color get neutrla4 => const Color(0xFF979797);
  static Color get neutrla5 => const Color(0xFF666666);
  static Color get neutrla6 => const Color(0xFF333333);
  static Color get neutrla7 => const Color(0xFF181818);

  static Color get success0 => const Color(0xFFE4FFF1);
  static Color get success1 => const Color(0xFF00D494);
  static Color get success2 => const Color(0xFF02A573);

  static Color get error0 => const Color(0xFFCF1322);
  static Color get error1 => const Color(0xFFD83232);

  static Color get primaryBlue => const Color(0xFF2E3B96);
  static Color get greyText01 => const Color(0xFF585858);
  static Color get greyText02 => const Color(0xFF606060);
}
