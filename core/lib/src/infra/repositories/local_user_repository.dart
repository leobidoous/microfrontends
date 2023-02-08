import 'package:dartz/dartz.dart';

import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/local_user_repository.dart';
import '../datasources/local_user_datasource.dart';

class LocalUserRepository extends ILocalUserRepository {
  final ILocalUserDatasource datasource;

  LocalUserRepository({required this.datasource});

  @override
  Future<Either<Exception, UserEntity>> getLocalUser() {
    return datasource.getLocalUser();
  }

  @override
  Future<Either<Exception, Unit>> setLocalUser({required UserEntity user}) {
    return datasource.setLocalUser(user: user);
  }

  @override
  Future<Either<Exception, Unit>> removeLocalUser() {
    return datasource.removeLocalUser();
  }

  @override
  Future<Either<Exception, TokenEntity>> getToken() {
    return datasource.getToken();
  }

  @override
  Future<Either<Exception, Unit>> removeToken() {
    return datasource.removeToken();
  }

  @override
  Future<Either<Exception, Unit>> setToken({required TokenEntity token}) {
    return datasource.setToken(token: token);
  }
}
