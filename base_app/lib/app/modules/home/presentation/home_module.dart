import 'package:core/core.dart'
    show Bind, ChildRoute, Modular, ModularRoute, Module;

import '../../../stores/app_store.dart';
import 'home_routes.dart';
import 'stores/home_store.dart';
import 'stores/main_bottom_bar_store.dart';
import 'stores/main_store.dart';
import 'views/home_page.dart';
import 'views/main_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// stores dependencies
    Bind.lazySingleton(
      (i) => HomeStore(appStore: i.get<AppStore>()),
    ),
    Bind.lazySingleton(
      (i) => MainStore(
        bottomBarStore: MainBottomBarStore(),
        appStore: i.get<AppStore>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const MainPage(),
      children: [
        ChildRoute(HomeRoutes.home.path, child: (_, args) => const HomePage()),
      ],
    ),
  ];
}
