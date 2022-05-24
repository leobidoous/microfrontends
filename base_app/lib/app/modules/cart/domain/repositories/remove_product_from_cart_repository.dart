import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';

abstract class IRemoveProductFromCartRepository {
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  });
  Future<Either<Exception, Unit>> clean();
}
