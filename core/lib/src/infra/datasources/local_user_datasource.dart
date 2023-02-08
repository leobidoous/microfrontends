import 'package:dartz/dartz.dart';

import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class ILocalUserDatasource {
  Future<Either<Exception, Unit>> removeLocalUser();
  Future<Either<Exception, UserEntity>> getLocalUser();
  Future<Either<Exception, Unit>> setLocalUser({required UserEntity user});
  Future<Either<Exception, TokenEntity>> getToken();
  Future<Either<Exception, Unit>> removeToken();
  Future<Either<Exception, Unit>> setToken({required TokenEntity token});
}
