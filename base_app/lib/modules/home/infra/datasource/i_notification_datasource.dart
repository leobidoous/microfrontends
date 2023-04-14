import 'package:core/core.dart';

import '../../domain/entities/notification_entity.dart';

abstract class INotificationDatasource {
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  });
}
