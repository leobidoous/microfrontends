
import 'package:core/core.dart';

import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/i_auth_datasource.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDatasource datasource;

  AuthRepository({required this.datasource});

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> createExternalUser({
    required UserEntity user,
  }) {
    return datasource.createExternalUser(user: user);
  }

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> refreshToken({
    required String phone,
    required String password,
  }) {
    return datasource.refreshToken(phone: phone, password: password);
  }

  @override
  Future<Either<Exception, Unit>> logout() {
    return datasource.logout();
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshFirebaseToken({
    required String refreshToken,
  }) {
    return datasource.refreshFirebaseToken(refreshToken: refreshToken);
  }

  @override
  Future<Either<Exception, Unit>> firebaseSignIn({required String token}) {
    return datasource.firebaseSignIn(token: token);
  }
}
