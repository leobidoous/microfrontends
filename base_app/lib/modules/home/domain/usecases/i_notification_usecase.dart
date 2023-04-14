import 'package:core/core.dart';

import '../entities/notification_entity.dart';

abstract class INotificationUsecase {
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  });
}
