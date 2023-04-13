import 'either.dart';

abstract class IGraphQlInterceptor {
  Future<Either<Exception, Unit>> onRequest();
  Future<Either<Exception, Unit>> onResponse();
  Future<Either<Exception, Unit>> onError();
}
