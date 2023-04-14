import 'package:core/core.dart';

import '../../../app/presentation/controllers/session_controller.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/i_notification_usecase.dart';

class NotificationsController
    extends GenController<Exception, List<NotificationEntity>> {
  final INotificationUsecase notificationUsecase;
  final SessionController sessionController;

  NotificationsController({
    required this.notificationUsecase,
    required this.sessionController,
  }) : super([]);

  Future<void> fetchNotifications() async {
    await execute(
      () => notificationUsecase.fetchNotifications(
        marketplaceId: sessionController.customer.marketplaceId,
        customerId: sessionController.customer.id,
      ),
    );
  }
}
