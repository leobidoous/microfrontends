import 'package:core/core.dart';

abstract class ITokenRepository {
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  });
}
