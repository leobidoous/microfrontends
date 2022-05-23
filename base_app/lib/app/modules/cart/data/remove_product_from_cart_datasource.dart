import 'package:core/core.dart';

import '../../home/domain/entities/product_entity.dart';
import '../infra/datasources/remove_product_from_cart_datasource.dart';

class RemoveProductFromCartDatasource extends IRemoveProductFromCartDatasource {
  final IPreferencesStorageDriver storage;

  RemoveProductFromCartDatasource({required this.storage});

  @override
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  }) {
    return storage.removeStringByKey(
      key: 'key',
    );
  }
}
