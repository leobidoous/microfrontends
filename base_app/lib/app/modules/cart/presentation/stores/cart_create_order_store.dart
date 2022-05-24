import 'package:core/core.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/create_order_usecase.dart';

class CartCreateOrderStore extends NotifierStore<Exception, OrderEntity>
    with Disposable {
  final ICreateOrderUsecase createOrderUsecase;

  CartCreateOrderStore({required this.createOrderUsecase})
      : super(OrderEntity());

  Future<void> createOrder() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    await createOrderUsecase(order: state).then((value) {
      value.fold(
        (l) => setError(l),
        (r) => update(OrderEntity()),
      );
    });
    setLoading(false);
  }

  @override
  void dispose() {
    destroy();
  }
}
