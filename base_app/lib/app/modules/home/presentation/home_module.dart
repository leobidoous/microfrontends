import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../../core/app_routes.dart';
import '../../../stores/app_store.dart';
import '../../cart/presentation/cart_module.dart';
import '../../my_orders/presentation/my_orders_module.dart';
import '../../product_details/presentation/product_details_page.dart';
import '../data/datasources/add_product_to_cart_datasource.dart';
import '../data/datasources/get_products_datasource.dart';
import '../data/datasources/get_promotions_datasource.dart';
import '../domain/usecases/add_product_to_cart_usecase.dart';
import '../domain/usecases/get_products_usecase.dart';
import '../domain/usecases/get_promotions_usecase.dart';
import '../infra/repositories/add_product_to_cart_repository.dart';
import '../infra/repositories/get_products_repository.dart';
import '../infra/repositories/get_promotions_repository.dart';
import 'home_page.dart';
import 'stores/home_bottom_bar_store.dart';
import 'stores/home_products_store.dart';
import 'stores/home_promotions_store.dart';
import 'stores/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Products dependencies
    Bind.lazySingleton(
      (i) => AddProductToCartDatasource(
        storage: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => AddProductToCartRepository(
        datasource: i.get<AddProductToCartDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => AddProductToCartUsecase(
        repository: i.get<AddProductToCartRepository>(),
      ),
    ),

    /// Products dependencies
    Bind.lazySingleton(
      (i) => GetProductsUsecase(repository: i.get<GetProductsRepository>()),
    ),
    Bind.lazySingleton(
      (i) => GetProductsRepository(datasource: i.get<GetProductsDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => GetProductsDatasource(httpDriver: i.get<DioClient>()),
    ),

    /// Promotions dependencies
    Bind.lazySingleton(
      (i) => GetPromotionsUsecase(repository: i.get<GetPromotionsRepository>()),
    ),
    Bind.lazySingleton(
      (i) => GetPromotionsRepository(
        datasource: i.get<GetPromotionsDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetPromotionsDatasource(httpDriver: i.get<DioClient>()),
    ),

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
        userStore: i.get<LoggedUserStore>(),
        logoutUsecase: i.get<LogoutUsecase>(),
        productsStore: HomeProductsStore(
          usecase: i.get<GetProductsUsecase>(),
        ),
        bottomBarStore: HomeBottomBarStore(),
        addProductToCartUsecase: i.get<AddProductToCartUsecase>(),
        promotionsStore: HomePromotionsStore(
          usecase: i.get<GetPromotionsUsecase>(),
        ),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute(
          AppRoutes.cart,
          module: CartModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          AppRoutes.myOrders,
          module: MyOrdersModule(),
          transition: TransitionType.noTransition,
        ),
      ],
    ),
    ChildRoute(
      '${AppRoutes.productDetails}/:id',
      child: (_, args) => ProductDetailsPage(product: args.data),
      transition: TransitionType.downToUp,
    ),
  ];
}
