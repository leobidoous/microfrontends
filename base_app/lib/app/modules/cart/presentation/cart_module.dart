import 'package:core/core.dart';

import '../data/get_cart_products_datasource.dart';
import '../domain/usecases/get_cart_products_usecase.dart';
import '../infra/repositories/get_cart_products_repository.dart';
import 'cart_page.dart';
import 'cart_store.dart';

class CartModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => GetCartProductsDatasource(
        storage: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetCartProductsRepository(
        datasource: i.get<GetCartProductsDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetCartProductsUsecase(
        repository: i.get<GetCartProductsRepository>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => CartStore(
        cartProductsUsecase: i.get<GetCartProductsUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const CartPage()),
  ];
}
