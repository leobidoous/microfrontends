import 'package:base_auth/base_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../stores/app_store.dart';
import 'home_page.dart';
import 'home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Logout dependencies
    Bind.lazySingleton(
      (i) => LogoutDatasource(datasource: i.get<LoggedUserDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LogoutRepository(datasource: i.get<LogoutDatasource>()),
    ),
    Bind.lazySingleton(
        (i) => LogoutUsecase(repository: i.get<LogoutRepository>())),

    Bind.lazySingleton(
      (i) => HomeStore(
        appStore: i.get<AppStore>(),
        logoutUsecase: i.get<LogoutUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
