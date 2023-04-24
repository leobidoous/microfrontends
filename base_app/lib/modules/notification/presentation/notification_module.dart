import 'package:core/core.dart';

import '../data/datasources/notification_datasource.dart';
import '../infra/repositories/notification_repository.dart';
import '../infra/usecases/notification_usecase.dart';
import 'notification_controller.dart';
import 'pages/notification_page.dart';

class NotificationModule extends Module {
  @override
  final List<Bind> binds = [
    /// Notifications
    Bind.lazySingleton<NotificationDatasource>(
      (i) => NotificationDatasource(
        storageDriver: i.get<FirebaseStorageDriver>(),
      ),
    ),
    Bind.lazySingleton<NotificationRepository>(
      (i) => NotificationRepository(
        datasource: i.get<NotificationDatasource>(),
      ),
    ),
    Bind.lazySingleton<NotificationUsecase>(
      (i) => NotificationUsecase(
        repository: i.get<NotificationRepository>(),
        session: i.get<SessionEntity>(),
      ),
    ),

    /// Controllers
    Bind.factory<NotificationController>(
      (i) => NotificationController(
        notificationUsecase: i.get<NotificationUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const NotificationPage(),
    ),
  ];
}
