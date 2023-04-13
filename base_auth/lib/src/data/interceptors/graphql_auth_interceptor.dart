import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/i_auth_usecase.dart';

class GraphQlAuthInterceptor extends IGraphQlInterceptor {
  GraphQlAuthInterceptor({
    required this.localUserUsecase,
    required this.authUsecase,
  });

  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;

  @override
  Future<Either<Exception, Unit>> onRequest() async {
    debugPrint('onRequest...');
    return Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> onResponse() async {
    debugPrint('onResponse...');
    return Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> onError() async {
    debugPrint('onError...');
    return Right(unit);
  }
}
