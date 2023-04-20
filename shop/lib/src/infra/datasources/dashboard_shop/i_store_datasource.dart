import 'package:core/core.dart';

import '../../../domain/entities/store_entity.dart';
import '../../../domain/entities/store_mall_entity.dart';

abstract class IStoreDatasource {
  Future<Either<Exception, List<StoreEntity>>> fetchStores({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, List<StoreMallEntity>>> fetchStoreMalls();
}
