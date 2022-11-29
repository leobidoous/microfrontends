import 'package:core/core.dart'
    show Either, HttpDriverResponse, TokenEntity, Unit;

import '../../domain/repositories/microsoft_sso_repository.dart';
import '../datasources/microsoft_sso_datasource.dart';

class MicrosoftSSORepository extends IMicrosoftSSORepository {
  final IMicrosoftSSODatasource datasource;

  MicrosoftSSORepository({required this.datasource});

  @override
  Future<Either<HttpDriverResponse, String>> getAuthorizeUrl() {
    return datasource.getAuthorizeUrl();
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> getToken({
    required String code,
  }) {
    return datasource.getToken(code: code);
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshToken({
    required String token,
    String? scope,
  }) {
    return datasource.refreshToken(token: token, scope: scope);
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> verifyToken({
    required String token,
  }) {
    return datasource.verifyToken(token: token);
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> getUserDetails({
    required TokenEntity token,
  }) {
    return datasource.getUserDetails(token: token);
  }
}
