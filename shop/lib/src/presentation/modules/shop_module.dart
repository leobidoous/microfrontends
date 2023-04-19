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
  static List<Bind> get exportedBind => [
        // Datasources
        Bind.factory(
          (i) => StoreDataSource(
            graphQlClient: i.get<GraphQlClientDriver>(),
          ),
        ),
        // Repositories
        Bind.factory<StoreRepository>(
          (i) => StoreRepository(
            dataSource: i.get<StoreDataSource>(),
          ),
        ),
        // Usecases
        Bind.factory<StoreUsecase>(
          (i) => StoreUsecase(
            repository: i.get<StoreRepository>(),
          ),
        ),
      ];

  @override
  final List<Bind> binds = [
    // Controllers
    Bind.factory(
      (i) => FilterShopController(),
    ),
    Bind.factory(
      (i) => DashboardShopController(),
    ),
    Bind.factory(
      (i) => FetchStoresController(
        usecase: i.get<StoreUsecase>(),
      ),
    ),
    Bind.factory(
      (i) => FetchStoreMallsController(
        usecase: i.get<StoreUsecase>(),
      ),
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
