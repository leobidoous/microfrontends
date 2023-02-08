import 'package:dartz/dartz.dart';

abstract class IFirebaseNotificationsDriver {
  Future<Either<Exception, Unit>> configure();
  Future<Either<Exception, Unit>> subscribeToTopic({
    required String topic,
  });
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  });
  Future<Either<Exception, String>> getToken();
}
