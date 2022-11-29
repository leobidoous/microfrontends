import 'package:flutter/material.dart';

import 'color/foreground/dark_foreground.dart';
import 'color/foreground/foreground_color_palette.dart';
import 'color/foreground/light_foreground.dart';
import 'color/palette/color_palette.dart';
import 'color/palette/dark_color_palette.dart';
import 'color/palette/light_color_palette.dart';
import 'spacing/spacing.dart';
import 'typography/typography_builder.dart';
import 'typography/typography_constants.dart';

///
/// New theming definitions.
///
/// Defines the default Light and Dark themes.
///
class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  /// Current [AppTheme] singleton instance
  static AppTheme get instance => _instance;

  ThemeData? _lightTheme;
  ThemeData? _darkTheme;

  ///
  /// Current Light theme definition
  ///
  ThemeData get lightTheme {
    _lightTheme ??= builder(
      colorPalette: LightColorPalette(),
      invertedForeground: DarkForeground(),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
    return _lightTheme!;
  }

  set lightTheme(ThemeData value) {
    _lightTheme = value;
  }

  ///
  /// Current Dark theme definition
  ///
  ThemeData get darkTheme {
    _darkTheme ??= builder(
      colorPalette: DarkColorPalette(),
      invertedForeground: LightForeground(),
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    );

    return _darkTheme!;
  }

  set darkTheme(ThemeData value) {
    _darkTheme = value;
  }

  ///
  /// Builds a theme, based on the provided colors.
  ///
  ThemeData builder({
    required IColorPalette colorPalette,
    required IForegroundColorPalette invertedForeground,
    required Brightness brightness,

    /// These colors are under revision by the UX team.
    /// They'll see how to put these colors inside our palette.
    /// We're using white(#fff) and dark(#000) by default.
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    final foreground = colorPalette.foreground;

    /// Uses old text theme just to get the base definition of some styles.
    final textTheme = TypographyBuilder.buildTextTheme(
      foreground.active,
      invertedForeground.active,
    );

    final appTextStyle =
        TypographyBuilder.buildAppTextStyle(textTheme, foreground);

    return ThemeData(
      useMaterial3: true,
      fontFamily: appFontFamily,
      primaryColor: colorPalette.primary,

      // TODO: background color será corrigida após definição dos UX
      scaffoldBackgroundColor: colorPalette.base,
      cardColor: colorPalette.base,
      canvasColor: colorPalette.base,
      backgroundColor: colorPalette.base,
      // TODO: background color será corrigida após definição dos UX

      extensions: [
        appTextStyle,
      ],
      iconTheme: IconThemeData(
        color: foreground.active,
        size: AppFontSize.button.value,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: appTextStyle.calloutMedium,
        iconTheme: IconThemeData(
          color: foreground.active,
        ),
      ),
      dividerColor: foreground.disabled,
      dividerTheme: const DividerThemeData(space: 0),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(backgroundColor),
        fillColor: MaterialStateProperty.all(foreground.active),
        side: BorderSide(color: foreground.disabled, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.xxs.value)),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(foreground.active),
        overlayColor: MaterialStateProperty.all(foreground.disabled),
      ),
      disabledColor: foreground.soft,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: colorPalette.secondary[50]!,
          ),
          borderRadius: BorderRadius.circular(Spacing.xs.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: colorPalette.secondary[50]!,
          ),
          borderRadius: BorderRadius.circular(Spacing.xs.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: colorPalette.base[700]!,
          ),
          borderRadius: BorderRadius.circular(Spacing.xs.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: foreground.soft),
          borderRadius: BorderRadius.circular(Spacing.xs.value),
        ),
        labelStyle: TextStyle(
          color: foreground.active,
          fontWeight: AppFontWeight.regular.value,
          fontSize: AppFontSize.body1.value,
          height: AppLineHeight.sm.value,
        ),
        hintStyle: TextStyle(
          color: foreground.disabled,
          fontWeight: AppFontWeight.regular.value,
          fontSize: AppFontSize.body1.value,
          height: AppLineHeight.sm.value,
        ),
        helperStyle: TextStyle(
          color: foreground.active,
          fontWeight: AppFontWeight.regular.value,
          fontSize: AppFontSize.caption.value,
          height: AppLineHeight.xs.value,
        ),
        errorStyle: TextStyle(
          color: colorPalette.deepOrange,
          fontWeight: AppFontWeight.regular.value,
          fontSize: AppFontSize.caption.value,
          height: AppLineHeight.xs.value,
        ),
      ),
      colorScheme: ColorScheme(
        primary: foreground.active,
        primaryContainer: foregroundColor,
        secondary: colorPalette.primary[700]!,
        secondaryContainer: colorPalette.primary[700]!,
        surface: backgroundColor,
        background: backgroundColor,
        error: colorPalette.deepOrange,
        onPrimary: backgroundColor,
        onSecondary: foreground.active,
        onSurface: foreground.active,
        onBackground: foreground.active,
        onError: backgroundColor,
        brightness: brightness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: Spacing.sm.height,
              horizontal: Spacing.xl.width,
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return colorPalette.base[200];
            }

            //TODO: Need definition
            // if (states.contains(MaterialState.pressed)) {
            //   return foregroundColor;
            // }

            return colorPalette.base[900];
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return foreground.disabled;
            }

            return invertedForeground.active;
          }),
          textStyle: MaterialStateProperty.all(
            appTextStyle.buttonMedium.copyWith(
              height: AppLineHeight.xs.value,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: Spacing.sm.height,
              horizontal: Spacing.xl.width,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          textStyle: MaterialStateProperty.all(
            appTextStyle.buttonMedium.copyWith(
              height: AppLineHeight.xs.value,
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: foreground.active, width: 1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: Spacing.xs.width,
              vertical: Spacing.xs.height,
            ),
          ),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return appTextStyle.buttonMedium.copyWith(
              color: states.contains(MaterialState.disabled)
                  ? foreground.soft
                  : foreground.active,
            );
          }),
        ),
      ),
      textTheme: TypographyBuilder.buildTextTheme(
        foreground.active,
        backgroundColor,
      ),
      scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(colorPalette.secondary[200]!),
        thumbVisibility: MaterialStateProperty.all(true),
        radius: Radius.circular(Spacing.md.value),
        thickness: MaterialStateProperty.all(Spacing.xxs.width),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorPalette.base,
        shape: StadiumBorder(
          side: BorderSide(color: colorPalette.base[200]!),
        ),
        showCheckmark: false,
        labelStyle: TextStyle(
          fontSize: AppFontSize.body2.value,
          fontWeight: AppFontWeight.medium.value,
          height: AppLineHeight.sm.value,
        ),
        selectedColor: foreground.active,
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(horizontal: Spacing.sm.width),
      ),
    );
  }
}
