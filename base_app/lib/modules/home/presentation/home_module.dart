import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../app/domain/usecases/user_usecase.dart';
import '../../app/presentation/app_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/user_controller.dart';
import 'home_page.dart';
import 'home_routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Stores
    Bind.lazySingleton(
      (i) => HomeController(
        logoutUsecase: DM.i.get<LogoutUsecase>(),
        userController: DM.i.get<UserController>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => UserController(
        DM.i.get<AppController>().user,
        userUsecase: DM.i.get<UserUsecase>(),
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ModuleRoute(HomeRoutes.wallet.path, module: WalletModule()),
  ];
}
