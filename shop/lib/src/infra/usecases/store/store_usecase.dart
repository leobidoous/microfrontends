import 'package:core/core.dart';

import '../../../domain/entities/store_entity.dart';
import '../../../domain/entities/store_mall_entity.dart';
import '../../../domain/repositories/store/i_store_repository.dart';
import '../../../domain/usecases/dashboard_shop/i_store_usecase.dart';

class StoreUsecase extends IStoreUsecase {
  final IStoreRepository repository;

  StoreUsecase({required this.repository});

  @override
  Future<Either<Exception, List<StoreEntity>>> fetchStores({
    required Map<String, dynamic> params,
  }) {
    return repository.fetchStores(params: params);
  }

  @override
  Future<Either<Exception, List<StoreMallEntity>>> fetchStoreMalls() {
    return repository.fetchStoreMalls();
  }
}
