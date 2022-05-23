import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';

abstract class IRemoveProductFromCartDatasource {
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  });
}
