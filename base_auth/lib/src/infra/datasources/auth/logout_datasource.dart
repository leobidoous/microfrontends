
import 'package:dartz/dartz.dart';

abstract class ILogoutDatasource {
  Future<Either<Exception, Unit>> call();
}
