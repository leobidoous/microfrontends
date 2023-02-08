
import 'package:dartz/dartz.dart';

abstract class ILogoutRepository {
  Future<Either<Exception, Unit>> call();
}
