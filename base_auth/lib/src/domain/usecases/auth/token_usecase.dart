import 'package:core/core.dart';

import '../../repositories/auth/token_repository.dart';

abstract class ITokenUsecase {
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  });
}

class TokenUsecase extends ITokenUsecase {
  final ITokenRepository repository;

  TokenUsecase({required this.repository});

  @override
  Future<Either<Exception, TokenEntity>> refreshToken({
    required TokenDataEntity token,
  }) {
    return repository.refreshToken(token: token);
  }
}
