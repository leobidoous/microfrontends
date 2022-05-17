import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../core/app_routes.dart';
import 'modules/home/presentation/home_module.dart';
import 'shared/pages/splash/splash_page.dart';
import 'shared/pages/splash/splash_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
    ModuleRoute(AppRoutes.home, module: HomeModule()),
    ModuleRoute(AppRoutes.auth, module: AuthModule()),
  ];
}
