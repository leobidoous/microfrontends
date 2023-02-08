// class AppColorSchemeExtensionBase {
//   static colorSheme =
// }

import 'package:flutter/material.dart';

/// Default colorSchemeExtension
final baseLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary:  Colors.grey.shade900,
  onPrimary: Colors.grey.shade400,
  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.white,
  secondary: Colors.yellowAccent.shade700,
  onSecondary: Colors.yellow.shade600,
  secondaryContainer: Colors.white,
  onSecondaryContainer: Colors.white,
  tertiary: Colors.white,
  onTertiary: Colors.white,
  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.white,
  error: Colors.red,
  onError: Colors.red.shade200,
  errorContainer: Colors.white,
  onErrorContainer: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.blueGrey.shade700,
  onSurface: Colors.blueGrey.shade300,
  surfaceVariant: Colors.white,
  onSurfaceVariant: Colors.white,
  outline: Colors.white,
  outlineVariant: Colors.white,
  shadow: Colors.grey.shade300,
  scrim: Colors.white,
  inverseSurface: Colors.white,
  onInverseSurface: Colors.white,
  inversePrimary: Colors.white,
  surfaceTint: Colors.white,
);

/// Default colorSchemeExtension
final baseDarkColorScheme = baseLightColorScheme.copyWith(
  brightness: Brightness.dark,
  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.white,
  secondaryContainer: Colors.white,
  onSecondaryContainer: Colors.white,
  tertiary: Colors.white,
  onTertiary: Colors.white,
  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.white,
  errorContainer: Colors.white,
  onErrorContainer: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  surface: Colors.white,
  onSurface: Colors.white,
  surfaceVariant: Colors.white,
  onSurfaceVariant: Colors.white,
  outline: Colors.white,
  outlineVariant: Colors.white,
  shadow: Colors.white,
  scrim: Colors.white,
  inverseSurface: Colors.white,
  onInverseSurface: Colors.white,
  inversePrimary: Colors.white,
  surfaceTint: Colors.white,
);
