
import 'package:dartz/dartz.dart';

abstract class IConnectivityService {
  Future<Either<Exception, Unit>> isOnline();
}
