import '../interfaces/either.dart';

abstract class ILocationService {
  Future<Either<Exception, Unit>> init();
}
