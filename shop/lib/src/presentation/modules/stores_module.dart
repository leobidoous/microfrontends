import 'package:core/core.dart';

import '../../data/datasources/dashboard_shop/store_datasource.dart';
import '../../infra/repositories/dashboard_shop/store_repository.dart';
import '../../infra/usecases/store/store_usecase.dart';
import '../controllers/details_shop/details_shop_controller.dart';
import '../controllers/stores/fetch_stores_controller.dart';
import '../pages/Stores/Stores_page.dart';
import '../pages/details_shop/details_shop_page.dart';
import '../routes/stores_routes.dart';

class StoresModule extends Module {
  static List<Bind> get exportedBind => [
        // Datasources
        Bind.factory(
          (i) => StoreDataSource(
            graphQlClient: i.get<GraphQlClientDriver>(),
          ),
        ),
        //Repositories
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
      (i) => FetchStoresController(
        usecase: i.get<StoreUsecase>(),
      ),
    ),

    /// Controllerss
    Bind.factory(
      (i) => DetailsShopController(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => StoresPage(
        brand: args.data,
      ),
    ),
    ChildRoute(
      StoresRoutes.detailsStore.path,
      child: (_, args) => DetailsShopPage(store: args.data),
    ),
  ];
}
