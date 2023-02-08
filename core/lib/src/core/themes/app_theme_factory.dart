import 'package:flutter/material.dart';

import '../utils/dependency_manager.dart';
import 'app_color_scheme.dart';
import 'app_theme_base.dart';
import 'responsive/responsive_extension.dart';
import 'typography/typography_builder.dart';
import 'typography/typography_constants.dart';

extension ContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ColorSchemeExtension on ColorScheme {
  bool get isDarkTheme => brightness == Brightness.dark;
  Color get colorPrimaryDarkest => DM.i.get<ColorScheme>().colorPrimaryDarkest;
  Color get colorPrimaryDark => DM.i.get<ColorScheme>().colorPrimaryDark;
  Color get colorPrimaryMedium => DM.i.get<ColorScheme>().colorPrimaryMedium;
  Color get colorPrimaryLight => DM.i.get<ColorScheme>().colorPrimaryLight;
  Color get colorPrimaryLightest =>
      DM.i.get<ColorScheme>().colorPrimaryLightest;
  Color get colorPrimarySuperlight =>
      DM.i.get<ColorScheme>().colorPrimarySuperlight;
  Color get colorSecondaryDarkest =>
      DM.i.get<ColorScheme>().colorSecondaryDarkest;
  Color get colorSecondaryDark => DM.i.get<ColorScheme>().colorSecondaryDark;
  Color get colorSecondaryDarkMedium =>
      DM.i.get<ColorScheme>().colorSecondaryDarkMedium;
  Color get colorSecondaryMedium =>
      DM.i.get<ColorScheme>().colorSecondaryMedium;
  Color get colorSecondaryLight => DM.i.get<ColorScheme>().colorSecondaryLight;
  Color get colorSecondaryLightest =>
      DM.i.get<ColorScheme>().colorSecondaryLightest;
  Color get colorSecondaryLightmodeSuperlight =>
      DM.i.get<ColorScheme>().colorSecondaryLightmodeSuperlight;
  Color get colorTertiaryDark => DM.i.get<ColorScheme>().colorTertiaryDark;
  Color get colorTertiaryMedium => DM.i.get<ColorScheme>().colorTertiaryMedium;
  Color get colorTertiaryLight => DM.i.get<ColorScheme>().colorTertiaryLight;
  Color get colorBlueLight => AppThemeBase.colorBlueLight;
  Color get colorNeutralLightmodeDarkest =>
      DM.i.get<ColorScheme>().colorNeutralLightmodeDarkest;
  Color get colorNeutralLightmodeDark =>
      DM.i.get<ColorScheme>().colorNeutralLightmodeDark;
  Color get colorNeutralLightmodeLight =>
      DM.i.get<ColorScheme>().colorNeutralLightmodeLight;
  Color get colorNeutralLightmodeLightest =>
      DM.i.get<ColorScheme>().colorNeutralLightmodeLightest;
  Color get colorSystemErrorDark =>
      DM.i.get<ColorScheme>().colorSystemErrorDark;
  Color get colorSystemErrorDefault =>
      DM.i.get<ColorScheme>().colorSystemErrorDefault;
  Color get colorSystemErrorLight =>
      DM.i.get<ColorScheme>().colorSystemErrorLight;
  Color get colorBaseBackgroundCreditCardError =>
      DM.i.get<ColorScheme>().colorBaseBackgroundCreditCardError;
  Color get colorInactiveSwitchDark =>
      DM.i.get<ColorScheme>().colorInactiveSwitchDark;
  Gradient get gradientPageBackgroundError =>
      AppThemeBase.gradientPageBackgroundError;
  Gradient get gradientDestak {
    return isDarkTheme
        ? DM.i.get<ColorScheme>().gradientDestakDark
        : DM.i.get<ColorScheme>().gradientDestakLight;
  }

  Gradient get gradientDestakDark {
    return DM.i.get<ColorScheme>().gradientDestakLight;
  }

  Gradient get gradientDestakLight {
    return DM.i.get<ColorScheme>().gradientDestakDark;
  }

  Gradient get gradientDarkerToDark =>
      DM.i.get<ColorScheme>().gradientDarkerToDark;

  Gradient get gradientDarkerToDarkLight =>
      DM.i.get<ColorScheme>().gradientDarkerToDarkLight;

  Gradient get gradientDarkerToDarkBlack =>
      DM.i.get<ColorScheme>().gradientDarkerToDarkBlack;

  Gradient get gradientDarkerToDarkStandard =>
      DM.i.get<ColorScheme>().gradientDarkerToDarkStandard;

  Gradient get gradientDarkToDarker =>
      DM.i.get<ColorScheme>().gradientDarkToDarker;

  Gradient get gradientRedToDark => DM.i.get<ColorScheme>().gradientRedToDark;

  Color get colorBaseBackgroundStandard =>
      DM.i.get<ColorScheme>().colorBaseBackgroundStandard;

  Gradient get gradientBackgroundStandard =>
      DM.i.get<ColorScheme>().gradientBackgroundStandard;

  Color get colorBaseBackgroundPlatinum =>
      DM.i.get<ColorScheme>().colorBaseBackgroundPlatinum;

  Gradient get gradientBackgroundPlatinum =>
      DM.i.get<ColorScheme>().gradientBackgroundPlatinum;

  Color get colorBaseBackgroundBlack =>
      DM.i.get<ColorScheme>().colorBaseBackgroundBlack;

  Gradient get gradientBackgroundBlack =>
      DM.i.get<ColorScheme>().gradientBackgroundBlack;

  Gradient get gradientBackgroundStandardPreviewCard =>
      DM.i.get<ColorScheme>().gradientBackgroundStandardPreviewCard;

  Gradient get gradientBackgroundPlatinumPreviewCard =>
      DM.i.get<ColorScheme>().gradientBackgroundPlatinumPreviewCard;

  Gradient get gradientBackgroundBlackPreviewCard =>
      DM.i.get<ColorScheme>().gradientBackgroundBlackPreviewCard;

  Color get colorSystemSuccessDefault => AppThemeBase.colorSystemSuccessDefault;

  Color get colorCustomSliderBackground =>
      AppThemeBase.colorGraySliderBackground;
}

extension TextThemeExtension on TextTheme {
  String get fontFamily => AppThemeBase.fontFamily;
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
    final appTextStyle = TypographyBuilder.buildAppTextStyle;
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppThemeBase.fontFamily,
      primaryColor: baseLightColorScheme.primary,
      scaffoldBackgroundColor: Colors.grey.shade100,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      cardColor: baseLightColorScheme.surface,
      canvasColor: baseLightColorScheme.onSurface,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: AppFontSize.iconButton.value,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarHeight: AppThemeBase.appBarHeight,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: AppFontSize.iconButton.value,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: baseLightColorScheme.primary,
        thickness: AppThemeBase.lineHeightTight,
        space: 32.responsiveHeight,
        indent: AppThemeBase.lineHeightTight,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(
          AppThemeBase.colorPrimarySuperlight,
        ),
        fillColor: MaterialStateProperty.all(
          AppThemeBase.colorPrimaryDark,
        ),
        side: const BorderSide(
          color: AppThemeBase.colorNeutralLightmodeLight,
          width: 1.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        thumbColor: baseLightColorScheme.secondary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(
          AppThemeBase.colorPrimaryDark,
        ),
        overlayColor: MaterialStateProperty.all(
          AppThemeBase.colorNeutralLightmodeLight,
        ),
      ),
      disabledColor: Colors.grey.shade300,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppThemeBase.colorTertiaryLight,
          ),
          borderRadius: AppThemeBase.borderRadiusSM,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppThemeBase.colorTertiaryLight,
          ),
          borderRadius: AppThemeBase.borderRadiusSM,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppThemeBase.colorPrimaryMedium,
          ),
          borderRadius: AppThemeBase.borderRadiusSM,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppThemeBase.colorNeutralLightmodeLightest,
          ),
          borderRadius: AppThemeBase.borderRadiusSM,
        ),
        labelStyle: appTextStyle.labelMedium,
        hintStyle: appTextStyle.labelMedium,
        helperStyle: appTextStyle.displayMedium,
        errorStyle: appTextStyle.bodySmall.copyWith(
          color: baseLightColorScheme.error,
        ),
      ),
      colorScheme: baseLightColorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppThemeBase.colorNeutralLightmodeLightest;
            }

            if (states.contains(MaterialState.pressed)) {
              return AppThemeBase.colorPrimaryDarkest;
            }

            return AppThemeBase.colorPrimaryDark;
          }),
          foregroundColor: MaterialStateProperty.all(
            AppThemeBase.colorPrimarySuperlight,
          ),
          textStyle: MaterialStateProperty.all(
            appTextStyle.bodyMedium.copyWith(
              color: AppThemeBase.colorPrimarySuperlight,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppThemeBase.buttonHeight),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor:
              MaterialStateProperty.all(AppThemeBase.colorPrimarySuperlight),
          textStyle: MaterialStateProperty.all(appTextStyle.bodyMedium),
          side: MaterialStateProperty.all(
            BorderSide(
              color: AppThemeBase.colorPrimaryDark,
              width: AppLineHeight.xs.value,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppThemeBase.buttonHeight,
              ),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          textStyle: MaterialStateProperty.resolveWith((states) {
            return appTextStyle.bodyMedium.copyWith(
              color: states.contains(MaterialState.disabled)
                  ? baseLightColorScheme.primary
                  : Colors.white,
            );
          }),
        ),
      ),
      textTheme: TextTheme(
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
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(
          AppThemeBase.colorTertiaryMedium,
        ),
        thumbVisibility: MaterialStateProperty.all(true),
        radius: AppThemeBase.borderRadiusLG.topLeft,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppThemeBase.colorPrimarySuperlight,
        shape: const StadiumBorder(
          side: BorderSide(
            color: AppThemeBase.colorPrimaryLight,
          ),
        ),
        showCheckmark: false,
        labelStyle: appTextStyle.labelMedium,
        selectedColor: AppThemeBase.colorPrimaryDark,
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(horizontal: 16.responsiveWidth),
      ),
    );
  }

  static ThemeData createDarkTheme() {
    final themeData = createLightTheme();
    final appTextStyle = TypographyBuilder.buildAppTextStyle;
    return themeData.copyWith(
      primaryColor: AppThemeBase.colorPrimaryLightest,
      scaffoldBackgroundColor: AppThemeBase.colorPrimaryDark,
      cardColor: AppThemeBase.colorPrimaryDark,
      canvasColor: AppThemeBase.colorPrimaryDarkest,
      iconTheme: const IconThemeData(
        color: AppThemeBase.colorPrimaryLightest,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(
        iconTheme: themeData.appBarTheme.iconTheme?.copyWith(
          color: AppThemeBase.colorPrimaryLightest,
        ),
      ),
      dividerColor: AppThemeBase.colorPrimarySuperlight.withOpacity(0.1),
      checkboxTheme: themeData.checkboxTheme.copyWith(
        checkColor: MaterialStateProperty.all(AppThemeBase.colorPrimaryDark),
        fillColor: MaterialStateProperty.all(
          AppThemeBase.colorPrimarySuperlight,
        ),
      ),
      radioTheme: themeData.radioTheme.copyWith(
        fillColor: MaterialStateProperty.all(
          AppThemeBase.colorPrimarySuperlight,
        ),
      ),
      disabledColor: AppThemeBase.colorPrimaryMedium,
      inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
        border: themeData.inputDecorationTheme.border?.copyWith(
          borderSide:
              themeData.inputDecorationTheme.border?.borderSide.copyWith(
            color: AppThemeBase.colorTertiaryDark,
          ),
        ),
        enabledBorder: themeData.inputDecorationTheme.enabledBorder?.copyWith(
          borderSide:
              themeData.inputDecorationTheme.enabledBorder?.borderSide.copyWith(
            color: AppThemeBase.colorTertiaryDark,
          ),
        ),
        focusedBorder: themeData.inputDecorationTheme.focusedBorder?.copyWith(
          borderSide:
              themeData.inputDecorationTheme.focusedBorder?.borderSide.copyWith(
            color: AppThemeBase.colorPrimaryMedium,
          ),
        ),
        disabledBorder: themeData.inputDecorationTheme.disabledBorder?.copyWith(
          borderSide: themeData.inputDecorationTheme.disabledBorder?.borderSide
              .copyWith(
            color: AppThemeBase.colorNeutralLightmodeDarkest,
          ),
        ),
        labelStyle: themeData.inputDecorationTheme.labelStyle?.copyWith(
          color: AppThemeBase.colorPrimarySuperlight,
        ),
        hintStyle: themeData.inputDecorationTheme.hintStyle?.copyWith(
          color: AppThemeBase.colorNeutralLightmodeDark,
        ),
        helperStyle: themeData.inputDecorationTheme.helperStyle?.copyWith(
          color: AppThemeBase.colorPrimarySuperlight,
        ),
      ),
      colorScheme: baseLightColorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: themeData.elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppThemeBase.colorPrimaryMedium.withOpacity(
                AppThemeBase.opacityLevelMedium,
              );
            }

            if (states.contains(MaterialState.pressed)) {
              return AppThemeBase.colorPrimaryLightest;
            }

            return AppThemeBase.colorPrimarySuperlight;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppThemeBase.colorPrimaryLight.withOpacity(
                AppThemeBase.opacityLevelMedium,
              );
            }

            return AppThemeBase.colorPrimaryDark;
          }),
          textStyle: MaterialStateProperty.all(
            appTextStyle.bodyMedium.copyWith(
              color: AppThemeBase.colorPrimarySuperlight,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: themeData.textButtonTheme.style?.copyWith(
          textStyle: MaterialStateProperty.resolveWith(
            (states) {
              return appTextStyle.bodyMedium.copyWith(
                color: states.contains(MaterialState.disabled)
                    ? AppThemeBase.colorPrimaryMedium
                    : AppThemeBase.colorPrimarySuperlight,
              );
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(
            AppThemeBase.colorPrimarySuperlight,
          ),
          textStyle: MaterialStateProperty.all(appTextStyle.bodyMedium),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: AppThemeBase.colorPrimarySuperlight,
              width: 1,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppThemeBase.buttonHeight,
              ),
            ),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppThemeBase.colorPrimaryDark,
        shape: const StadiumBorder(
          side: BorderSide(
            color: AppThemeBase.colorPrimaryLight,
          ),
        ),
        showCheckmark: false,
        labelStyle: appTextStyle.labelMedium,
        selectedColor: AppThemeBase.colorPrimarySuperlight,
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(horizontal: 16.responsiveWidth),
      ),
    );
  }
}
