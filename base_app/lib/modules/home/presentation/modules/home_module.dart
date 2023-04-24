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
import '../../data/home_datasource.dart';
import '../../infra/repositories/home_repository.dart';
import '../../infra/usecases/home_usecase.dart';
import '../controllers/home_controller.dart';
import '../pages/home_page.dart';
import '../routes/dashboard_routes.dart';
import '../routes/home_routes.dart';
import 'dashboard_module.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Home
    Bind.lazySingleton<HomeDatasource>(
      (i) => HomeDatasource(
        client: i.get<DioClientDriver>(),
        locationService: i.get<LocationService>(),
        permissionService: i.get<PermissionService>(),
        baseUrl: i.get<EnvironmentEntity>().endpointCampaign,
      ),
    ),
    Bind.lazySingleton<HomeRepository>(
      (i) => HomeRepository(datasource: i.get<HomeDatasource>()),
    ),
    Bind.lazySingleton<HomeUsecase>(
      (i) => HomeUsecase(repository: i.get<HomeRepository>()),
    ),

    /// Session
    Bind.lazySingleton<SessionController>(
      (i) => SessionController(
        i.get<AppController>().session,
        authUsecase: i.get<AuthUsecase>(),
        localUserUsecase: i.get<LocalUserUsecase>(),
      ),
    ),
    Bind.factory<SessionEntity>((i) => i.get<SessionController>().state),

    /// Shopping
    Bind.factory<ShoppingEntity>(
      (i) => ShoppingEntity(
        id: 3,
        name: 'Shopping bonsucesso',
        type: 'tiaguinho',
        latitude: 'latitude',
        longitude: 'longitude',
        qrcode: 'qrcode',
        idAdministrator: 1,
        updatedAt: 'updatedAt',
        createdAt: 'createdAt',
        address: 'Rua das oliveiras, nº 20 - 65040-380',
        logoImage: '',
        cnpj: 'cnpj',
      ),
    ),

    /// Controllers
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(
        sessionController: i.get<SessionController>(),
        homeUsecase: i.get<HomeUsecase>(),
      ),
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
        ModuleRoute(
          WalletRoutes(parent: HomeRoutes.start).initial.path,
          transition: TransitionType.fadeIn,
          module: WalletModule(),
        ),
        ModuleRoute(
          PayRoutes(parent: HomeRoutes.start).initial.path,
          transition: TransitionType.fadeIn,
          module: PayModule(),
        ),
        ModuleRoute(ProfileRoutes.root.path, module: ProfileModule()),
      ],
    ),
    ModuleRoute(
      ParkingRoutes(parent: HomeRoutes.root).initial.path,
      module: ParkingModule(
        walletPath: HomeRoutes.start.concate<WalletRoutes>(WalletRoutes.root),
      ),
    ),
    ModuleRoute(PayRoutes.root.path, module: PayModule()),
    ChildRoute(
      SharedRoutes.fallback.path,
      child: (_, args) => const FallbackPage(),
    ),
  ];
}
