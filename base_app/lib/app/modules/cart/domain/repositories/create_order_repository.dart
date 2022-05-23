import 'package:core/core.dart';

import '../entities/order_entity.dart';

abstract class ICreateOrderRepository {
  Future<Either<Exception, Unit>> call({required OrderEntity order});
}
