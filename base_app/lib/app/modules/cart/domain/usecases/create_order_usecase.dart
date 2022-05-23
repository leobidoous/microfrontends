import 'package:core/core.dart';

import '../entities/order_entity.dart';
import '../repositories/create_order_repository.dart';

abstract class ICreateOrderUsecase {
  Future<Either<Exception, Unit>> call({required OrderEntity order});
}

class CreateOrderUsecase extends ICreateOrderUsecase {
  final ICreateOrderRepository repository;

  CreateOrderUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> call({required OrderEntity order}) {
    return repository(order: order);
  }
}
