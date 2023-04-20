import 'package:core/core.dart';

import '../../../domain/entities/store_entity.dart';
import '../../../domain/entities/store_mall_entity.dart';
import '../../../domain/repositories/store/i_store_repository.dart';
import '../../datasources/dashboard_shop/i_store_datasource.dart';

class StoreRepository implements IStoreRepository {
  const StoreRepository({required this.dataSource});
  final IStoreDatasource dataSource;

  @override
  Future<Either<Exception, List<StoreEntity>>> fetchStores({
    required Map<String, dynamic> params,
  }) async {
    return dataSource.fetchStores(params: params);
  }

  @override
  Future<Either<Exception, List<StoreMallEntity>>> fetchStoreMalls() async {
    return dataSource.fetchStoreMalls();
  }
}
