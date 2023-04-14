import 'package:core/core.dart';

import '../../data/dashboard_datasource.dart';
import '../../data/notification_datasource.dart';
import '../../infra/repositories/dashboard_repository.dart';
import '../../infra/repositories/notification_repository.dart';
import '../../infra/usecases/dashboard_usecase.dart';
import '../../infra/usecases/notification_usecase.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/notifications_controller.dart';
import '../pages/dashboard/dashboard_page.dart';

class DashboardModule extends Module {
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
      ),
    ),

    /// Dashboard
    Bind.lazySingleton<DashboardDatasource>(
      (i) => DashboardDatasource(
        baseUrl: i.get<EnvironmentEntity>().baseUrlParking,
        client: i.get<DioClientDriver>(),
      ),
    ),
    Bind.lazySingleton<DashboardRepository>(
      (i) => DashboardRepository(
        datasource: i.get<DashboardDatasource>(),
      ),
    ),
    Bind.lazySingleton<DashboardUsecase>(
      (i) => DashboardUsecase(
        repository: i.get<DashboardRepository>(),
      ),
    ),

    /// Controllers
    Bind.factory<DashboardController>(
      (i) => DashboardController(
        notificationsController: i.get(),
        dashboardUsecase: i.get(),
      ),
    ),
    Bind.factory<NotificationsController>(
      (i) => NotificationsController(
        sessionController: i.get(),
        notificationUsecase: i.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const DashboardPage(),
    ),
  ];
}
