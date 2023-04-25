import 'package:core/core.dart';

import '../../../shop.dart';
import '../../data/datasources/dashboard_shop/store_datasource.dart';
import '../../infra/repositories/dashboard_shop/store_repository.dart';
import '../../infra/usecases/store/store_usecase.dart';
import '../controllers/dashboard_shop/dashboard_shop_controller.dart';
import '../controllers/dashboard_shop/fetch_store_malls_controller.dart';
import '../controllers/dashboard_shop/filter_shop_controller.dart';
import '../controllers/stores/fetch_stores_controller.dart';
import '../pages/shop/filter_shop_page.dart';
import '../pages/shop/shop_page.dart';

class ShopModule extends Module {
  static List<Bind> get exportedBinds => [
        // Datasources
        Bind.factory<StoreDatasource>(
          (i) => StoreDatasource(graphQlClient: i.get<GraphQlClientDriver>()),
        ),
        // Repositories
        Bind.factory<StoreRepository>(
          (i) => StoreRepository(dataSource: i.get<StoreDatasource>()),
        ),
        // Usecases
        Bind.factory<StoreUsecase>(
          (i) => StoreUsecase(repository: i.get<StoreRepository>()),
        ),
      ];

  @override
  final List<Bind> binds = [
    ...exportedBinds,
    // Controllers
    Bind.factory<FilterShopController>((i) => FilterShopController()),
    Bind.factory<DashboardShopController>((i) => DashboardShopController()),
    Bind.factory<FetchStoresController>(
      (i) => FetchStoresController(usecase: i.get<StoreUsecase>()),
    ),
    Bind.factory<FetchStoreMallsController>(
      (i) => FetchStoreMallsController(usecase: i.get<StoreUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const ShopPage()),
    ChildRoute(
      ShopRoutes.filterShop.path,
      child: (_, args) => const FilterShopPage(),
    ),
  ];
}
