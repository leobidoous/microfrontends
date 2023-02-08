import 'package:dartz/dartz.dart' show Either, Unit;

import '../../domain/entities/received_notifications_entity.dart'
    show ReceivedNotificationEntity;
import '../../domain/services/local_notifications_service.dart'
    show ILocalNotificationsService;
import '../drivers/local_notifications_driver.dart'
    show ILocalNotificationsDriver;

class LocalNotificationsService extends ILocalNotificationsService {
  final ILocalNotificationsDriver localNotificationsDriver;

  LocalNotificationsService({required this.localNotificationsDriver});

  @override
  Future<Either<Exception, Unit>> init() {
    return localNotificationsDriver.init();
  }

  @override
  Future<Either<Exception, Unit>> requestPermissions() {
    return localNotificationsDriver.requestPermissions();
  }

  @override
  Future<Either<Exception, Unit>> scheduleNotification() {
    return localNotificationsDriver.scheduleNotification();
  }

  @override
  Future<Either<Exception, Unit>> showNotification({
    required ReceivedNotificationEntity notification,
  }) {
    return localNotificationsDriver.showNotification(
      notification: notification,
    );
  }
}
