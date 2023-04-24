import 'package:core/core.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/i_notification_repository.dart';
import '../../domain/usecases/i_notification_usecase.dart';

class NotificationUsecase implements INotificationUsecase {
  final INotificationRepository repository;
  final SessionEntity session;

  NotificationUsecase({
    required this.repository,
    required this.session,
  });

  /// Retorna todas as notificações do usuário logado
  @override
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications() {
    return repository.fetchNotifications(
      marketplaceId: session.claims.marketplaceId,
      customerId: session.customer.id,
    );
  }

  @override
  Future<Either<Exception, Unit>> markAsRead({required String notificationId}) {
    return repository.markAsRead(
      marketplaceId: session.claims.marketplaceId,
      customerId: session.customer.id,
      notificationId: notificationId,
    );
  }
}
