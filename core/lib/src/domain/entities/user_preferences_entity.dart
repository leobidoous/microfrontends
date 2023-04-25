import 'package:flutter/material.dart';

class UserPreferencesEntity {
  final String id;
  final ThemeMode? themeMode;
  final bool? showOnboarding;

  UserPreferencesEntity({
    required this.id,
    this.themeMode,
    this.showOnboarding,
  });
}
