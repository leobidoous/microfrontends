import 'package:flutter/material.dart' show ThemeMode;

import '../../domain/entities/session_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/repositories/i_local_user_repository.dart';
import '../datasources/i_local_user_datasource.dart';

class LocalUserRepository extends ILocalUserRepository {
  final ILocalUserDatasource datasource;

  LocalUserRepository({required this.datasource});

  @override
  Future<Either<Exception, ThemeMode>> getThemeMode() {
    return datasource.getThemeMode();
  }

  @override
  Future<Either<Exception, Unit>> setThemeMode({required ThemeMode themeMode}) {
    return datasource.setThemeMode(themeMode: themeMode);
  }

  @override
  Future<Either<Exception, SessionEntity>> getSession() {
    return datasource.getSession();
  }

  @override
  Future<Either<Exception, Unit>> removeSession() {
    return datasource.removeSession();
  }

  @override
  Future<Either<Exception, Unit>> setSession({required SessionEntity session}) {
    return datasource.setSession(session: session);
  }
}
