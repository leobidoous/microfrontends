import 'package:flutter/material.dart';

import '../../domain/entities/environment_entity.dart';
import '../utils/dependency_manager.dart';
import 'app_theme_factory.dart';

///
/// ThemeData factory
///
abstract class ThemeFactory {
  /// Get/Create a light [ThemeData] instance.
  ///
  /// Factories for v1 and v2 works as a lazy singleton. 
  /// If the current ThemeData is null, a new instance is created, 
  /// otherwise, the current instance is returned.
  static ThemeData light() {
    final themeVersion = DM.i.get<EnvironmentEntity>().themeVersion;

    switch (themeVersion) {
      default:
        return AppThemeFactory.instance.currentLightTheme;
    }
  }

  /// Get/Create a dark [ThemeData] instance.
  ///
  /// Factories for v1 and v2 works as a lazy singleton. 
  /// If the current ThemeData is null, a new instance is created, 
  /// otherwise, the current instance is returned.
  static ThemeData dark() {
    final themeVersion = DM.i.get<EnvironmentEntity>().themeVersion;

    switch (themeVersion) {
      default:
        return AppThemeFactory.instance.currentDarkTheme;
    }
  }
}
