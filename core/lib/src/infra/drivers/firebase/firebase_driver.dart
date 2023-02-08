
import 'package:dartz/dartz.dart';

abstract class IFirebaseDriver {
  Future<Either<Exception, Unit>> init();
}
