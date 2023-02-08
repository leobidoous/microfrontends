import 'package:core/core.dart';

import '../../../domain/repositories/auth/token_repository.dart';
import '../../datasources/auth/token_datasource.dart';

class TokenRepository extends ITokenRepository {
  final ITokenDatasource datasource;

  TokenRepository({required this.datasource});

  @override
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  }) {
    return datasource.refreshToken(token: token);
  }
}
