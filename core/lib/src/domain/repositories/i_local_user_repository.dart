import 'package:flutter/material.dart';

import '../entities/session_entity.dart';
import '../interfaces/either.dart';

abstract class ILocalUserRepository {
  Future<Either<Exception, Unit>> setThemeMode({required ThemeMode themeMode});
  Future<Either<Exception, ThemeMode>> getThemeMode();
  Future<Either<Exception, Unit>> setSession({required SessionEntity session});
  Future<Either<Exception, SessionEntity>> getSession();
  Future<Either<Exception, Unit>> removeSession();
}
