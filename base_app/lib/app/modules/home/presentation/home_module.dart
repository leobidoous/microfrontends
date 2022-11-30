import 'package:core/core.dart'
    show
        Bind,
        ChildRoute,
        Modular,
        ModularRoute,
        Module,
        ModuleRoute,
        PreferencesStorageDriver;

import '../../../stores/app_store.dart';
import '../../settings/presentation/settings_module.dart';
import '../../stocks/presentation/stocks_module.dart';
import '../data/datasources/recent_researches_datasource.dart';
import '../domain/usecases/recent_researches_usecase.dart';
import '../infra/repositories/recent_researches_repository.dart';
import 'home_routes.dart';
import 'stores/home_store.dart';
import 'stores/main_bottom_bar_store.dart';
import 'stores/main_store.dart';
import 'stores/recent_researches_store.dart';
import 'views/home_page.dart';
import 'views/main_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// recent researches dependencies
    Bind.lazySingleton(
      (i) => RecentResearchesDatasource(
        storageDriver: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => RecentResearchesRepository(
        datasource: i.get<RecentResearchesDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => RecentResearchesUsecase(
        repository: i.get<RecentResearchesRepository>(),
      ),
    ),

    /// stores dependencies
    Bind.lazySingleton(
      (i) => HomeStore(
        recentResearchesUsecase: i.get<RecentResearchesUsecase>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => RecentResearchesStore(
        recentResearchesUsecase: i.get<RecentResearchesUsecase>(),
      ),
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
        ModuleRoute(HomeRoutes.settings.path, module: SettingsModule()),
      ],
    ),
    ModuleRoute(HomeRoutes.stocks.path, module: StocksModule()),
  ];
}
