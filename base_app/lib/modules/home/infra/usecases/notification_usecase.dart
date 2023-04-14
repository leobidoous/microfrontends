import 'package:core/core.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/i_notification_repository.dart';
import '../../domain/usecases/i_notification_usecase.dart';

class NotificationUsecase implements INotificationUsecase {
  final INotificationRepository repository;

  NotificationUsecase({
    required this.repository,
  });

  /// Retorna todas as notificações do usuário logado
  @override
  Future<Either<Exception, List<NotificationEntity>>> fetchNotifications({
    required String marketplaceId,
    required String customerId,
  }) async {
    return await repository.fetchNotifications(
      marketplaceId: marketplaceId,
      customerId: customerId,
    );
  }
}
