import 'package:core/core.dart';

abstract class ILogoutDatasource {
  Future<Either<Exception, Unit>> call();
}