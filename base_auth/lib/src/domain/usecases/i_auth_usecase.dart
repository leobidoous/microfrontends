

import 'package:core/core.dart';

abstract class IAuthUsecase {
  Future<Either<Exception, Unit>> firebaseSignIn({required String token});
  Future<Either<HttpDriverResponse, ExternalUserEntity>> createExternalUser({
    required UserEntity user,
  });
  Future<Either<HttpDriverResponse, ExternalUserEntity>> refreshToken({
    required String phone,
    required String password,
  });
  Future<Either<HttpDriverResponse, TokenEntity>> refreshFirebaseToken({
    required String refreshToken,
  });
  Future<Either<Exception, Unit>> logout();
}
