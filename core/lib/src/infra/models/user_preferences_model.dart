import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_preferences_entity.dart';

class UserPreferencesModel extends UserPreferencesEntity with EquatableMixin {
  UserPreferencesModel({
    required super.id,
    required super.themeMode,
    required super.showOnboarding,
  });

  factory UserPreferencesModel.fromMap(Map<String, dynamic> map) {
    return UserPreferencesModel(
      id: map['id'] ?? '',
      themeMode: map['themeMode'] ?? ThemeMode.system,
      showOnboarding: map['showOnboarding'] ?? true,
    );
  }

  factory UserPreferencesModel.fromEntity(UserPreferencesEntity entity) {
    return UserPreferencesModel(
      id: entity.id,
      themeMode: entity.themeMode,
      showOnboarding: entity.showOnboarding,
    );
  }

  UserPreferencesModel copyWith({
    ThemeMode? themeMode,
    bool? showOnboarding,
  }) {
    return UserPreferencesModel(
      id: id,
      themeMode: themeMode ?? this.themeMode,
      showOnboarding: showOnboarding ?? this.showOnboarding,
    );
  }

  factory UserPreferencesModel.fromJson(String source) =>
      UserPreferencesModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  UserPreferencesEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'themeMode': themeMode,
      'showOnboarding': showOnboarding,
    };
  }

  @override
  List<Object?> get props => [
        id,
        themeMode,
        showOnboarding,
      ];

  @override
  bool? get stringify => true;
}
