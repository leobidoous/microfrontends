import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../notification/infra/usecases/notification_usecase.dart';
import '../../../notification/presentation/notification_controller.dart';
import '../../data/dashboard_datasource.dart';
import '../../infra/repositories/dashboard_repository.dart';
import '../../infra/usecases/dashboard_usecase.dart';
import '../controllers/dashboard_controller.dart';
import '../pages/dashboard/dashboard_page.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    /// Wallet
    ...WalletModule.exportedBinds,

    /// Dashboard
    Bind.lazySingleton<DashboardDatasource>(
      (i) => DashboardDatasource(
        baseUrl: i.get<EnvironmentEntity>().endpointCampaign,
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
        dashboardUsecase: i.get<DashboardUsecase>(),
      ),
    ),
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
      child: (_, args) => const DashboardPage(),
    ),
  ];
}
