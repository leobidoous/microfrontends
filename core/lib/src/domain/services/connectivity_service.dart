
import '../../../core.dart';

abstract class IConnectivityService {
  Future<Either<Exception, Unit>> isOnline();
}
