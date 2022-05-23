
import 'package:core/core.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/create_order_repository.dart';
import '../datasources/create_order_datasource.dart';

class CreateOrderRepository extends ICreateOrderRepository {
  final ICreateOrderDatasource datasource;

  CreateOrderRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call({required OrderEntity order}) {
    return datasource(order: order);
  }
}
