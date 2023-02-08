import 'package:dartz/dartz.dart';

import '../entities/token_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/local_user_repository.dart';

abstract class ILocalUserUsecase {
  Future<Either<Exception, Unit>> removeLocalUser();
  Future<Either<Exception, UserEntity>> getLocalUser();
  Future<Either<Exception, Unit>> setLocalUser({required UserEntity user});
  Future<Either<Exception, TokenEntity>> getToken();
  Future<Either<Exception, Unit>> removeToken();
  Future<Either<Exception, Unit>> setToken({required TokenEntity token});
}

class LocalUserUsecase extends ILocalUserUsecase {
  final ILocalUserRepository repository;

  LocalUserUsecase({required this.repository});

  @override
  Future<Either<Exception, UserEntity>> getLocalUser() {
    return repository.getLocalUser();
  }

  @override
  Future<Either<Exception, Unit>> setLocalUser({required UserEntity user}) {
    return repository.setLocalUser(user: user);
  }

  @override
  Future<Either<Exception, Unit>> removeLocalUser() {
    return repository.removeLocalUser();
  }

  @override
  Future<Either<Exception, TokenEntity>> getToken() {
    return repository.getToken();
  }

  @override
  Future<Either<Exception, Unit>> removeToken() {
    return repository.removeToken();
  }

  @override
  Future<Either<Exception, Unit>> setToken({
    required TokenEntity token,
  }) {
    return repository.setToken(token: token);
  }
}
