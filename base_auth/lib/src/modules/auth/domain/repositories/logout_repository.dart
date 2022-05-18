import 'package:core/core.dart';

abstract class ILogoutRepository {
  Future<Either<Exception, Unit>> call();
}
