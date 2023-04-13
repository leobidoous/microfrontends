import 'package:core/core.dart';

import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/usecases/i_auth_usecase.dart';

class AuthUsecase extends IAuthUsecase {
  final IAuthRepository repository;

  AuthUsecase({required this.repository});

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> createExternalUser({
    required UserEntity user,
  }) {
    return repository.createExternalUser(user: user);
  }

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> refreshToken({
    required String phone,
    required String password,
  }) {
    return repository.refreshToken(phone: phone, password: password);
  }

  @override
  Future<Either<Exception, Unit>> logout({bool navigateToLogin = true}) {
    return repository.logout(navigateToLogin: navigateToLogin);
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshFirebaseToken({
    required String refreshToken,
  }) {
    return repository.refreshFirebaseToken(refreshToken: refreshToken);
  }

  @override
  Future<Either<Exception, Unit>> firebaseSignIn({required String token}) {
    return repository.firebaseSignIn(token: token);
  }

  @override
  bool sessionIsValid(SessionEntity session) {
    return repository.sessionIsValid(session);
  }
}
