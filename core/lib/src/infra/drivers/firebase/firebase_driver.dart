import '../../../../core.dart';

abstract class IFirebaseDriver {
   Future<Either<Exception, Unit>> init();
}
