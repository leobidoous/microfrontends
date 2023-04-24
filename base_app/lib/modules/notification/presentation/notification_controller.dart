import 'package:core/core.dart';

import '../domain/entities/notification_entity.dart';
import '../domain/usecases/i_notification_usecase.dart';

class NotificationController
    extends GenController<Exception, List<NotificationEntity>> {
  final INotificationUsecase notificationUsecase;

  NotificationController({required this.notificationUsecase}) : super([]);

  Future<void> fetchNotifications() async {
    await execute(() => notificationUsecase.fetchNotifications());
  }

  Future<void> markAsRead(NotificationEntity notification) async {
    setLoading(true);
    await notificationUsecase.markAsRead(notificationId: notification.id);
    setLoading(false);
  }
}
