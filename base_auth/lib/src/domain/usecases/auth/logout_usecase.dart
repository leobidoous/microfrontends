
import 'package:dartz/dartz.dart';

import '../../repositories/auth/logout_repository.dart';

abstract class ILogoutUsecase {
  Future<Either<Exception, Unit>> call();
}

class LogoutUsecase extends ILogoutUsecase {
  final ILogoutRepository repository;

  LogoutUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> call() {
    return repository();
  }
}
