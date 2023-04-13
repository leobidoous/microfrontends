import 'package:flutter/material.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class ILocalUserDatasource {
  Future<Either<Exception, Unit>> setThemeMode({required ThemeMode themeMode});
  Future<Either<Exception, ThemeMode>> getThemeMode();
  Future<Either<Exception, Unit>> setSession({required SessionEntity session});
  Future<Either<Exception, SessionEntity>> getSession();
  Future<Either<Exception, Unit>> removeSession();
}
