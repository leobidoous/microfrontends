import 'package:core/core.dart';

import '../entities/notification_entity.dart';

abstract class INotificationUsecase {
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications();
  Future<Either<Exception, Unit>> markAsRead({required String notificationId});
}
