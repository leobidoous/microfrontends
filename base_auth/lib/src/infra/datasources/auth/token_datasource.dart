import 'package:core/core.dart';

abstract class ITokenDatasource {
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  });
}
