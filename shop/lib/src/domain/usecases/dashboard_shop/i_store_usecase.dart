import 'package:core/core.dart';

import '../../entities/store_entity.dart';
import '../../entities/store_mall_entity.dart';

abstract class IStoreUsecase {
  Future<Either<Exception, List<StoreEntity>>> fetchStores({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, List<StoreMallEntity>>> fetchStoreMalls();
}
