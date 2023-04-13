import '../interfaces/either.dart';

abstract class IGraphQlService {
  Future<Either<Exception, Unit>> init();
}
