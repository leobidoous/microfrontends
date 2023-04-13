import 'package:flutter/material.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/repositories/i_local_user_repository.dart';
import '../../domain/usecases/i_local_user_usecase.dart';

class LocalUserUsecase extends ILocalUserUsecase {
  final ILocalUserRepository repository;

  LocalUserUsecase({required this.repository});

  @override
  Future<Either<Exception, ThemeMode>> getThemeMode() {
    return repository.getThemeMode();
  }

  @override
  Future<Either<Exception, Unit>> setThemeMode({required ThemeMode themeMode}) {
    return repository.setThemeMode(themeMode: themeMode);
  }

  @override
  Future<Either<Exception, SessionEntity>> getSession() {
    return repository.getSession();
  }

  @override
  Future<Either<Exception, Unit>> removeSession() {
    return repository.removeSession();
  }

  @override
  Future<Either<Exception, Unit>> setSession({required SessionEntity session}) {
    return repository.setSession(session: session);
  }
}
