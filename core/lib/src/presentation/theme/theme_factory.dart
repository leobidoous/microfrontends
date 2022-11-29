import 'package:flutter/material.dart';

import 'base/app_theme.dart';

///
/// ThemeData factory
///
abstract class ThemeFactory {
  /// Get/Create a light [ThemeData] instance.
  ///
  /// Factories for v1 and v2 works as a lazy singleton.
  /// If the current ThemeData is null, a new instance
  /// is created, otherwise, the current instance is returned.
  static ThemeData light() => AppTheme.instance.lightTheme;

  /// Get/Create a dark [ThemeData] instance.
  ///
  /// Factories for v1 and v2 works as a lazy singleton.
  /// If the current ThemeData is null, a new instance is
  /// created, otherwise, the current instance is returned.
  static ThemeData dark() => AppTheme.instance.darkTheme;
}
