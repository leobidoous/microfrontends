import 'package:core/core.dart' show Either, Unit;

abstract class ILogoutDatasource {
  Future<Either<Exception, Unit>> call();
}
