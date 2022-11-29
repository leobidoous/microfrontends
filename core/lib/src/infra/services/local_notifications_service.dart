import 'package:dartz/dartz.dart';

import '../../domain/entities/received_notifications_entity.dart';
import '../../domain/services/local_notifications_service.dart';
import '../drivers/local_notifications_driver.dart';

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
