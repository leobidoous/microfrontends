import '../../../core.dart';

abstract class ILocalNotificationsService {
  Future<Either<Exception, Unit>> init();
  Future<Either<Exception, Unit>> requestPermissions();
  Future<Either<Exception, Unit>> showNotification({
    required ReceivedNotificationEntity notification,
  });
  Future<Either<Exception, Unit>> scheduleNotification();
}
