import 'package:core/core.dart'
    show Either, HttpDriverResponse, TokenEntity, Unit;

import '../repositories/microsoft_sso_repository.dart';

abstract class IMicrosoftSSOUsecase {
  Future<Either<HttpDriverResponse, String>> getAuthorizeUrl();
  Future<Either<HttpDriverResponse, TokenEntity>> getToken({
    required String code,
  });
  Future<Either<HttpDriverResponse, TokenEntity>> refreshToken({
    required String token,
    String? scope,
  });
  Future<Either<HttpDriverResponse, Unit>> verifyToken({required String token});
  Future<Either<HttpDriverResponse, Unit>> getUserDetails({
    required TokenEntity token,
  });
}

class MicrosoftSSOUsecase extends IMicrosoftSSOUsecase {
  final IMicrosoftSSORepository repository;

  MicrosoftSSOUsecase({required this.repository});

  @override
  Future<Either<HttpDriverResponse, String>> getAuthorizeUrl() {
    return repository.getAuthorizeUrl();
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> getToken({
    required String code,
  }) {
    return repository.getToken(code: code);
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshToken({
    required String token,
    String? scope,
  }) {
    return repository.refreshToken(token: token, scope: scope);
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> verifyToken({
    required String token,
  }) {
    return repository.verifyToken(token: token);
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> getUserDetails({
    required TokenEntity token,
  }) {
    return repository.getUserDetails(token: token);
  }
}
