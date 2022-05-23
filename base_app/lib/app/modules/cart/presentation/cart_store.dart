import 'package:core/core.dart';

import '../../home/domain/entities/product_entity.dart';
import '../domain/usecases/get_cart_products_usecase.dart';

class CartStore extends NotifierStore<Exception, List<ProductEntity>>
    with Disposable {
  final IGetCartProductsUsecase cartProductsUsecase;

  CartStore({required this.cartProductsUsecase}) : super([]);

  Future<void> getCartProducts() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    await cartProductsUsecase().then((value) {
      value.fold((l) => setError(l), (r) => update(r));
    });
    setLoading(false);
  }

  @override
  void dispose() {
    destroy();
  }
}
