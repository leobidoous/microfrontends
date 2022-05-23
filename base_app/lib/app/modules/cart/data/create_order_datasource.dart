import 'package:core/core.dart';

import '../domain/entities/order_entity.dart';
import '../infra/datasources/create_order_datasource.dart';

class CreateOrderDatasource extends ICreateOrderDatasource {
  final IPreferencesStorageDriver storage;

  CreateOrderDatasource({required this.storage});

  @override
  Future<Either<Exception, Unit>> call({required OrderEntity order}) {
    return storage.removeStringByKey(
      key: 'key',
    );
  }
}
