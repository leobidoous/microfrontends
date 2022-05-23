import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../../stores/app_store.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/add_product_to_cart_usecase.dart';
import 'home_bottom_bar_store.dart';
import 'home_products_store.dart';
import 'home_promotions_store.dart';

class HomeStore extends NotifierStore<Exception, int> with Disposable {
  final AppStore appStore;
  final ILogoutUsecase logoutUsecase;
  final LoggedUserStore userStore;
  final HomeBottomBarStore bottomBarStore;
  final IAddProductToCartUsecase addProductToCartUsecase;

  final HomeProductsStore productsStore;
  final HomePromotionsStore promotionsStore;

  HomeStore({
    required this.appStore,
    required this.logoutUsecase,
    required this.userStore,
    required this.productsStore,
    required this.promotionsStore,
    required this.bottomBarStore,
    required this.addProductToCartUsecase,
  }) : super(0);

  Future<Either<Exception, Unit>> logout() async {
    return logoutUsecase();
  }

  Future<Either<Exception, Unit>> addProductToCart({
    required ProductEntity product,
  }) {
    return addProductToCartUsecase(product: product);
  }

  @override
  void dispose() {
    bottomBarStore.destroy();
    destroy();
  }
}
