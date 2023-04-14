import 'package:core/core.dart';

import '../domain/entities/notification_entity.dart';
import '../infra/datasource/i_notification_datasource.dart';
import '../infra/models/notification_model.dart';

class NotificationDatasource implements INotificationDatasource {
  final IFirebaseStorageDriver storageDriver;

  NotificationDatasource({
    required this.storageDriver,
  });

  @override
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  }) async {
    final path =
        'marketplaces/$marketplaceId/customers/$customerId/notifications';

    final response = await storageDriver.getCollection(
      filters: QuerySnapshotFiltersEntity(
        collection: path,
        orderByField: 'date',
        orderDescending: true,
        limit: 20,
      ),
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          final notifications = List<NotificationEntity>.empty(growable: true);
          r.docs.forEach((notify) {
            notifications.add(NotificationModel.fromMap(notify.data()));
          });
          return Right(notifications);
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }
}
