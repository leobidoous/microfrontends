import 'package:core/core.dart';

import '../../../infra/datasources/auth/token_datasource.dart';

class TokenDatasource extends ITokenDatasource {
  final IHttpDriver client;

  TokenDatasource({required this.client});

  @override
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  }) async {
    final response = await client.post(
      '/v1/login/refresh-token',
      data: TokenDataModel.fromEntity(token).toMap,
    );

    return response.fold(
      (l) => Left(Exception(l.statusMessage)),
      (r) async {
        try {
          final token = TokenModel.fromMap(r.data['data']);
          return Right(token);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
