import 'package:core/core.dart' show Either, Unit;

abstract class ILogoutRepository {
  Future<Either<Exception, Unit>> call();
}
