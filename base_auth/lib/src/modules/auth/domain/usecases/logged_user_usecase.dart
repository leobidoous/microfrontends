import 'package:core/core.dart';

import '../repositories/logged_user_repository.dart';

abstract class ILoggedUserUsecase {
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser();
  Future<Either<Exception, Unit>> removeLoggedUser();
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  });
}

class LoggedUserUsecase extends ILoggedUserUsecase {
  final ILoggedUserRepository repository;

  LoggedUserUsecase({required this.repository});

  @override
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser() {
    return repository.getLoggedUser();
  }

  @override
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  }) {
    return repository.saveLoggedUser(user: user);
  }

  @override
  Future<Either<Exception, Unit>> removeLoggedUser() {
    return repository.removeLoggedUser();
  }
}
