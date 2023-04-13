import 'package:flutter/material.dart' show ThemeMode;

import '../../core/constants/user_constants.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/datasources/i_local_user_datasource.dart';
import '../../infra/drivers/preferences_storage_driver.dart';
import '../../infra/models/session_model.dart';

class LocalUserDatasource extends ILocalUserDatasource {
  final IPreferencesStorageDriver prefsDriver;

  LocalUserDatasource({required this.prefsDriver});

  @override
  Future<Either<Exception, SessionEntity>> getSession() async {
    final response = await prefsDriver.getStringByKey(
      key: UserConstants.session,
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(SessionModel.fromJson(r));
        } catch (e) {
          return Left(Exception('LocalUserDatasource().getSession: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> setSession({
    required SessionEntity session,
  }) async {
    return prefsDriver.setStringByKey(
      key: UserConstants.session,
      value: SessionModel.fromEntity(session).toJson,
    );
  }

  @override
  Future<Either<Exception, Unit>> removeSession() async {
    return prefsDriver.removeStringByKey(key: UserConstants.session);
  }

  @override
  Future<Either<Exception, ThemeMode>> getThemeMode() async {
    final response = await prefsDriver.getStringByKey(
      key: UserConstants.themeMode,
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        late final ThemeMode themeMode;
        switch (r) {
          case 'dark':
            themeMode = ThemeMode.dark;
            break;
          case 'light':
            themeMode = ThemeMode.light;
            break;
          default:
            themeMode = ThemeMode.system;
            break;
        }
        return Right(themeMode);
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> setThemeMode({
    required ThemeMode themeMode,
  }) async {
    return await prefsDriver.setStringByKey(
      key: UserConstants.themeMode,
      value: themeMode.name,
    );
  }
}
