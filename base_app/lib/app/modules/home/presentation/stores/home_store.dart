import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../../stores/app_store.dart';
import 'home_bottom_bar_store.dart';
import 'home_products_store.dart';
import 'home_promotions_store.dart';

class HomeStore extends NotifierStore<Exception, int> {
  final LogoutUsecase logoutUsecase;
  final AppStore appStore;
  final LoggedUserStore userStore;
  final bottomBarStore = HomeBottomBarStore();

  final HomeProductsStore productsStore;
  final HomePromotionsStore promotionsStore;

  HomeStore({
    required this.appStore,
    required this.logoutUsecase,
    required this.userStore,
    required this.productsStore,
    required this.promotionsStore,
  }) : super(0);

  Future<Either<Exception, Unit>> logout() async {
    return logoutUsecase();
  }
}
