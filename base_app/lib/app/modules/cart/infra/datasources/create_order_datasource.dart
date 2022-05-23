import 'package:core/core.dart';

import '../../domain/entities/cart_entity.dart';

abstract class ICreateOrderDatasource {
  Future<Either<Exception, CartEntity>> call({required});
}
