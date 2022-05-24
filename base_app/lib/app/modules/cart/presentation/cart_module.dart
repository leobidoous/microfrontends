import 'package:core/core.dart';

import '../data/create_order_datasource.dart';
import '../data/get_cart_products_datasource.dart';
import '../data/remove_product_from_cart_datasource.dart';
import '../domain/usecases/create_order_usecase.dart';
import '../domain/usecases/get_cart_products_usecase.dart';
import '../domain/usecases/remove_product_from_cart_usecase.dart';
import '../infra/repositories/create_order_repository.dart';
import '../infra/repositories/get_cart_products_repository.dart';
import '../infra/repositories/remove_product_from_cart_repository.dart';
import 'cart_page.dart';
import 'stores/cart_create_order_store.dart';
import 'stores/cart_store.dart';

class CartModule extends Module {
  @override
  final List<Bind> binds = [
    /// Create order dependencies
    Bind.lazySingleton(
      (i) => CreateOrderDatasource(
        storage: i.get<PreferencesStorageDriver>(),
        httpDriver: i.get<DioClient>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => CreateOrderRepository(
        datasource: i.get<CreateOrderDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => CreateOrderUsecase(
        repository: i.get<CreateOrderRepository>(),
      ),
    ),

    /// Remove cart products dependencies
    Bind.lazySingleton(
      (i) => RemoveProductFromCartDatasource(
        storage: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => RemoveProductFromCartRepository(
        datasource: i.get<RemoveProductFromCartDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => RemoveProductFromCartUsecase(
        repository: i.get<RemoveProductFromCartRepository>(),
      ),
    ),

    /// Cart products dependencies
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
        cartCreateOrderStore: CartCreateOrderStore(
          createOrderUsecase: i.get<CreateOrderUsecase>(),
        ),
        cartProductsUsecase: i.get<GetCartProductsUsecase>(),
        removeProductUsecase: i.get<RemoveProductFromCartUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => CartPage(pageController: args.data),
    ),
  ];
}
