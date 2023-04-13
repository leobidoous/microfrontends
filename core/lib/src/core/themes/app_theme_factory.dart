import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color_scheme.dart';
import 'app_colors_base.dart';
import 'app_theme_base.dart';
import 'typography/typography_builder.dart';
import 'typography/typography_constants.dart';

extension ContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness != Brightness.light;
}

extension TextThemeExtension on TextTheme {
  String get primaryFontFamily => AppThemeBase.primaryFontFamily;
  String get secodaryFontFamily => AppThemeBase.secodaryFontFamily;
  FontWeight get fontWeightBold => AppFontWeight.bold.value;
  FontWeight get fontWeightMedium => AppFontWeight.medium.value;
  FontWeight get fontWeightRegular => AppFontWeight.regular.value;
  FontWeight get fontWeightLight => AppFontWeight.light.value;
  double get lineHeightTight => AppThemeBase.lineHeightTight;
  double get lineHeightRegular => AppThemeBase.lineHeightRegular;
  double get lineHeightMedium => AppThemeBase.lineHeightMedium;
  double get lineHeightDistant => AppThemeBase.lineHeightDistant;
  double get lineHeightSuperDistant => AppThemeBase.lineHeightSuperDistant;
}

extension ThemeDataExtension on ThemeData {
  BorderRadius get borderRadiusNone => AppThemeBase.borderRadiusNone;
  BorderRadius get borderRadiusXSM => AppThemeBase.borderRadiusXSM;
  BorderRadius get borderRadiusSM => AppThemeBase.borderRadiusSM;
  BorderRadius get borderRadiusMD => AppThemeBase.borderRadiusMD;
  BorderRadius get borderRadiusLG => AppThemeBase.borderRadiusLG;

  double get borderWidthSM => AppThemeBase.borderWidthSM;
  double get borderWidthXS => AppThemeBase.borderWidthXS;
  double get opacityLevelSemiopaque => AppThemeBase.opacityLevelSemiopaque;
  double get opacityLevelIntense => AppThemeBase.opacityLevelIntense;
  double get opacityLevelMedium => AppThemeBase.opacityLevelMedium;
  double get opacityLevelLight => AppThemeBase.opacityLevelLight;
  double get opacityLevelSemiTransparent =>
      AppThemeBase.opacityLevelSemiTransparent;

  BoxShadow get shadowLightmodeLevel0 => AppThemeBase.shadowLightmodeLevel0;
  BoxShadow get shadowLightmodeLevel1 => AppThemeBase.shadowLightmodeLevel1;
  BoxShadow get shadowLightmodeLevel2 => AppThemeBase.shadowLightmodeLevel2;
  BoxShadow get shadowLightmodeLevel3 => AppThemeBase.shadowLightmodeLevel3;
  BoxShadow get shadowLightmodeLevel4 => AppThemeBase.shadowLightmodeLevel4;
  BoxShadow get shadowLightmodeLevel5 => AppThemeBase.shadowLightmodeLevel5;

  double get customRadioCircleSize => AppThemeBase.customRadioCircleSize;
  double get disclaimerIconSize => AppThemeBase.disclaimerIconSize;

  Border get borderZero => Border.all(width: 0, color: Colors.transparent);
}

extension InputDecorationThemeExtension on InputDecorationTheme {
  TextStyle? get floatingLabelStyle => labelStyle?.copyWith(
        height: AppThemeBase.lineHeightTight,
        fontWeight: AppFontWeight.bold.value,
      );
}

extension ElevatedButtonThemeDataExtension on ElevatedButtonThemeData {
  double get heightDefault => AppThemeBase.buttonHeight;
  double get heightSmall => AppThemeBase.buttonHeightSM;
  double get heightMedium => AppThemeBase.buttonHeightMD;
  double get heightLarge => AppThemeBase.buttonHeightLG;
}

extension AppBarThemeExtension on AppBarTheme {
  double get appBarHeight => AppThemeBase.appBarHeight;
}

class AppThemeFactory {
  AppThemeFactory._();
  static final AppThemeFactory _instance = AppThemeFactory._();
  static AppThemeFactory get instance => _instance;

  ThemeData? _currentLightTheme;
  ThemeData get currentLightTheme {
    _currentLightTheme ??= createLightTheme();
    return _currentLightTheme!;
  }

  set currentLightTheme(ThemeData value) {
    _currentLightTheme = value;
  }

  ThemeData? _currentDarkTheme;
  ThemeData get currentDarkTheme {
    _currentDarkTheme ??= createDarkTheme();
    return _currentDarkTheme!;
  }

  set currentDarkTheme(ThemeData value) {
    _currentDarkTheme = value;
  }

  static ThemeData createLightTheme() {
    final appTextStyle = TypographyBuilder.buildAppTextStyle(
      baseLightColorScheme,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: genpagColor,
      primaryColor: baseLightColorScheme.primary,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: baseLightColorScheme.primary,
        elevation: 0,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shadowColor: Colors.transparent,
      colorScheme: baseLightColorScheme,
      scaffoldBackgroundColor: AppColorsBase.kScaffoldBackgroundColorSecondary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: genTextTheme.copyWith(
        displayLarge: appTextStyle.displayLarge,
        displayMedium: appTextStyle.displayMedium,
        displaySmall: appTextStyle.displaySmall,
        headlineLarge: appTextStyle.headlineLarge,
        headlineMedium: appTextStyle.headlineMedium,
        headlineSmall: appTextStyle.headlineSmall,
        titleLarge: appTextStyle.titleLarge,
        titleMedium: appTextStyle.titleMedium,
        titleSmall: appTextStyle.titleSmall,
        bodyLarge: appTextStyle.bodyLarge,
        bodyMedium: appTextStyle.bodyMedium,
        bodySmall: appTextStyle.bodySmall,
        labelLarge: appTextStyle.labelLarge,
        labelMedium: appTextStyle.labelMedium,
        labelSmall: appTextStyle.labelSmall,
      ),
    );
  }

  static ThemeData createDarkTheme() {
    final themeData = createLightTheme();
    final appTextStyle = TypographyBuilder.buildAppTextStyle(
      baseDarkColorScheme,
    );
    return themeData.copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: baseDarkColorScheme.primary,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: baseDarkColorScheme.primary,
        elevation: 0,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shadowColor: Colors.transparent,
      colorScheme: baseDarkColorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: baseDarkColorScheme.background,
      textTheme: genTextTheme.copyWith(
        displayLarge: appTextStyle.displayLarge,
        displayMedium: appTextStyle.displayMedium,
        displaySmall: appTextStyle.displaySmall,
        headlineLarge: appTextStyle.headlineLarge,
        headlineMedium: appTextStyle.headlineMedium,
        headlineSmall: appTextStyle.headlineSmall,
        titleLarge: appTextStyle.titleLarge,
        titleMedium: appTextStyle.titleMedium,
        titleSmall: appTextStyle.titleSmall,
        bodyLarge: appTextStyle.bodyLarge,
        bodyMedium: appTextStyle.bodyMedium,
        bodySmall: appTextStyle.bodySmall,
        labelLarge: appTextStyle.labelLarge,
        labelMedium: appTextStyle.labelMedium,
        labelSmall: appTextStyle.labelSmall,
      ),
    );
  }
}
