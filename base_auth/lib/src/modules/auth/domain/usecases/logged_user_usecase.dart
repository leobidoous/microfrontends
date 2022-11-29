import 'package:core/core.dart' show Either, LoggedUserEntity, Unit;

import '../repositories/logged_user_repository.dart';

abstract class ILoggedUserUsecase {
  Future<Either<Exception, LoggedUserEntity>> getSavedUser();
  Future<Either<Exception, Unit>> removeSavedUser();
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  });
}

class LoggedUserUsecase extends ILoggedUserUsecase {
  final ILoggedUserRepository repository;

  LoggedUserUsecase({required this.repository});

  @override
  Future<Either<Exception, LoggedUserEntity>> getSavedUser() {
    return repository.getSavedUser();
  }

  @override
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  }) {
    return repository.saveLoggedUser(user: user);
  }

  @override
  Future<Either<Exception, Unit>> removeSavedUser() {
    return repository.removeSavedUser();
  }
}
