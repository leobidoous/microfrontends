import 'package:core/core.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/i_notification_repository.dart';
import '../datasources/i_notification_datasource.dart';

class NotificationRepository implements INotificationRepository {
  final INotificationDatasource datasource;

  NotificationRepository({required this.datasource});

  @override
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  }) async {
    return await datasource.fetchNotifications(
      marketplaceId: marketplaceId,
      customerId: customerId,
    );
  }

  @override
  Future<Either<Exception, Unit>> markAsRead({
    required String marketplaceId,
    required String customerId,
    required String notificationId,
  }) {
    return datasource.markAsRead(
      marketplaceId: marketplaceId,
      customerId: customerId,
      notificationId: notificationId,
    );
  }
}
