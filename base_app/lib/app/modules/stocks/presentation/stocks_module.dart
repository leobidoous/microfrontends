import 'package:core/core.dart'
    show Bind, ChildRoute, DioClientDriver, Modular, ModularRoute, Module;

import '../data/datasources/stocks_datasource.dart';
import '../domain/usecases/stocks_usecase.dart';
import '../infra/repositories/stocks_repository.dart';
import 'stocks_routes.dart';
import 'store/stocks_list_store.dart';
import 'views/stocks_details_page.dart';
import 'views/stocks_list_page.dart';

class StocksModule extends Module {
  @override
  final List<Bind> binds = [
    /// stocks dependencies
    Bind.lazySingleton(
      (i) => StocksDatasource(
        client: i.get<DioClientDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => StocksRepository(
        datasource: i.get<StocksDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => StocksUsecase(
        repository: i.get<StocksRepository>(),
      ),
    ),

    /// stores dependencies
    Bind.lazySingleton(
      (i) => StocksListStore(
        stocksDetailsUsecase: i.get<StocksUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => StocksListPage(recent: args.data),
    ),
    ChildRoute(
      StocksRoutes.stocksDetails.path,
      child: (_, args) => StocksDetailsPage(stocks: args.data),
    ),
  ];
}
