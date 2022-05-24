import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_cart_products_usecase.dart';
import '../../domain/usecases/remove_product_from_cart_usecase.dart';
import 'cart_create_order_store.dart';

class CartStore extends NotifierStore<Exception, List<ProductEntity>>
    with Disposable {
  final IGetCartProductsUsecase cartProductsUsecase;
  final IRemoveProductFromCartUsecase removeProductUsecase;
  final CartCreateOrderStore cartCreateOrderStore;

  CartStore({
    required this.cartProductsUsecase,
    required this.cartCreateOrderStore,
    required this.removeProductUsecase,
  }) : super([]);

  Future<void> getCartProducts() async {
    setLoading(true);
    await cartProductsUsecase().then((value) {
      value.fold(
        (l) => setError(l),
        (r) {
          final order = OrderEntity(
            items: r.map((e) => CartEntity(id: e.id)).toList(),
          );
          cartCreateOrderStore.update(order);
          update(r);
        },
      );
    });
    setLoading(false);
  }

  Future<void> removeProduct(ProductEntity product) async {
    await removeProductUsecase(product: product);
    await getCartProducts();
  }

  Future<void> cleanCart() async {
    await removeProductUsecase.clean();
    await getCartProducts();
  }

  double get getCartTotalPrice {
    double price = 0;
    state.forEach((e) => price += e.price);
    return price;
  }

  double get getCartDiscount {
    double discount = 0;
    state.forEach((e) => discount += e.discount ?? 0);
    return discount;
  }

  double get getCartSubtotal {
    double oldPrice = 0;
    state.forEach((e) => oldPrice += e.oldPrice ?? e.price);
    return oldPrice;
  }

  @override
  void dispose() {
    destroy();
  }
}
