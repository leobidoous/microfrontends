import 'package:core/core.dart';

import '../entities/notification_entity.dart';

abstract class INotificationRepository {
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  });
}
