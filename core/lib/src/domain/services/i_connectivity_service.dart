import '../interfaces/either.dart';

abstract class IConnectivityService {
  Future<Either<Exception, Unit>> isOnline();
}
