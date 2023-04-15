import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:parking/parking.dart';
import 'package:pay/pay.dart';
import 'package:wallet/wallet.dart';

import '../../../app/presentation/controllers/app_controller.dart';
import '../../../app/presentation/controllers/session_controller.dart';
import '../../../profile/presentation/profile_module.dart';
import '../../../profile/presentation/profile_routes.dart';
import '../../../shared/presentation/pages/fallback_page.dart';
import '../../../shared/presentation/shared_routes.dart';
import '../controllers/home_controller.dart';
import '../pages/home_page.dart';
import '../routes/dashboard_routes.dart';
import '../routes/home_routes.dart';
import 'dashboard_module.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Stores
    Bind.lazySingleton<SessionEntity>((i) => i.get<AppController>().session),
    Bind.lazySingleton<SessionController>(
      (i) => SessionController(
        i.get<SessionEntity>(),
        authUsecase: i.get<AuthUsecase>(),
      ),
    ),
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(sessionController: i.get<SessionController>()),
    ),
    Bind.lazySingleton<ZendeskController>(
      (i) => ZendeskController(session: i.get<SessionController>().state),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      HomeRoutes.start.path,
      transition: TransitionType.fadeIn,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute(DashboardRoutes.root.path, module: DashboardModule()),
        ModuleRoute(WalletRoutes.root.path, module: WalletModule()),
        ModuleRoute(ParkingRoutes.root.path, module: ParkingModule()),
        ModuleRoute(ProfileRoutes.root.path, module: ProfileModule()),
      ],
    ),
    ModuleRoute(PayRoutes.root.path, module: PayModule()),
    ChildRoute(
      SharedRoutes.fallback.path,
      child: (_, args) => const FallbackPage(),
    ),
  ];
}
