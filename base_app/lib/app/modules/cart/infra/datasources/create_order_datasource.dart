import 'package:core/core.dart';

import '../../domain/entities/order_entity.dart';

abstract class ICreateOrderDatasource {
  Future<Either<Exception, Unit>> call({required OrderEntity order});
}
