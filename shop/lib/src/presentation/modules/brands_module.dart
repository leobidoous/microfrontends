import 'package:core/core.dart';

import '../../data/datasources/brands/store_brands_datasource.dart';
import '../../infra/repositories/brands/store_brands_repository.dart';
import '../../infra/usecases/brands/store_brands_usecase.dart';
import '../controllers/brands/fetch_store_brands_controller.dart';
import '../pages/Brands/Brands_page.dart';

class BrandsModule extends Module {
  static List<Bind> get exportedBind => [
        // Datasources
        Bind.factory(
          (i) => StoreBrandsDataSource(
            graphQlClient: i.get<GraphQlClientDriver>(),
          ),
        ),
        //Repositories
        Bind.factory<StoreBrandsRepository>(
          (i) => StoreBrandsRepository(
            dataSource: i.get<StoreBrandsDataSource>(),
          ),
        ),
        // Usecases
        Bind.factory<FetchStoreBrandsUsecase>(
          (i) => FetchStoreBrandsUsecase(
            repository: i.get<StoreBrandsRepository>(),
          ),
        ),
      ];

  @override
  final List<Bind> binds = [
    // Controllers
    Bind.factory(
      (i) => FetchStoreBrandsController(
        usecase: i.get<FetchStoreBrandsUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const BrandsPage()),
  ];
}