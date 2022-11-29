import 'package:core/core.dart'
    show Either, HttpDriverResponse, TokenEntity, Unit;

abstract class IMicrosoftSSORepository {
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
