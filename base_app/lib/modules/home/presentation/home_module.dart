import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../app/presentation/controllers/app_controller.dart';
import '../../app/presentation/controllers/session_controller.dart';
import 'controllers/home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Stores
    Bind.lazySingleton<SessionController>(
      (i) => SessionController(
        i.get<AppController>().session,
        authUsecase: i.get<AuthUsecase>(),
      ),
    ),
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(sessionController: i.get<SessionController>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
