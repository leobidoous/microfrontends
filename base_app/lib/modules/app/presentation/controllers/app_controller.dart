import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart' show ThemeMode;

class AppController extends GenController<Exception, Unit> {
  AppController({
    required this.localUserUsecase,
    required this.authUsecase,
  }) : super(unit);

  late SessionEntity session;
  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;
  late UserPreferencesEntity _userPreferences;
  UserPreferencesEntity get userPreferences => _userPreferences;

  Future<Either<Exception, SessionEntity>> getSession() async {
    final response = await localUserUsecase.getSession();
    return response.fold(
      (l) => Left(l),
      (session) async {
        this.session = session;
        if (!authUsecase.sessionIsValid(session)) {
          await authUsecase.logout(navigateToLogin: false);
          return Left(Exception('Invalid session.'));
        }
        return Right(session);
      },
    );
  }

  Future<UserPreferencesEntity> getUserPreferences(String userId) async {
    final response = await localUserUsecase.getUserPreferences(userId: userId);
    return response.fold(
      (l) {
        _userPreferences = UserPreferencesEntity(id: userId);
        return _userPreferences;
      },
      (userPreferences) async {
        _userPreferences = userPreferences;
        return userPreferences;
      },
    );
  }

  Future<Either<Exception, Unit>> setUserPreferences({
    ThemeMode? themeMode,
    bool? showOnboarding,
  }) {
    final prefs = UserPreferencesModel.fromEntity(_userPreferences).copyWith(
      themeMode: themeMode,
      showOnboarding: showOnboarding,
    );
    return localUserUsecase.setUserPreferences(preferences: prefs);
  }
}
