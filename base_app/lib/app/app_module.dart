import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../core/app_routes.dart';
import '../core/router_guards/auth_router_guards.dart';
import '../core/router_guards/logged_router_guard.dart';
import 'stores/app_store.dart';
import 'modules/home/presentation/home_module.dart';
import 'shared/pages/splash/splash_page.dart';
import 'shared/pages/splash/splash_store.dart';
import 'stores/app_theme_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    /// Stores dependencies
    Bind.lazySingleton((i) => AppThemeStore()),
    Bind.lazySingleton((i) => AppStore(themeStore: i.get<AppThemeStore>())),
    Bind.lazySingleton(
      (i) => SplashStore(loggedUserUsecase: i.get<LoggedUserUsecase>()),
    ),

    /// Local storage dependencies
    Bind.lazySingleton((i) => LocalStorageDriver()),

    /// Logged user dependencies
    Bind.lazySingleton(
      (i) => LoggedUserDatasource(storageDriver: i.get<LocalStorageDriver>()),
    ),
    Bind.lazySingleton(
      (i) => LoggedUserRepository(datasource: i.get<LoggedUserDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LoggedUserUsecase(repository: i.get<LoggedUserRepository>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
    ModuleRoute(
      AppRoutes.home,
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      guards: [LoggedRouterGuard()],
    ),
    ModuleRoute(
      AppRoutes.auth,
      module: AuthModule(),
      transition: TransitionType.fadeIn,
      guards: [AuthRouterGuard()],
    ),
    WildcardRoute(child: (_, args) => const NotFoundPage()),
  ];
}
