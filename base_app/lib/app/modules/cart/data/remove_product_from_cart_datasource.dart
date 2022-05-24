import 'package:core/core.dart';

import '../../../../core/constants/preferences_constants.dart';
import '../../home/domain/entities/product_entity.dart';
import '../../home/infra/models/product_model.dart';
import '../infra/datasources/remove_product_from_cart_datasource.dart';

class RemoveProductFromCartDatasource extends IRemoveProductFromCartDatasource {
  final IPreferencesStorageDriver storage;

  RemoveProductFromCartDatasource({required this.storage});

  @override
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  }) async {
    final response = await storage.getStringListByKey(
      key: PreferencesConstants.cartProducts,
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.any((e) => ProductModel.fromJson(e).id == product.id)) {
          r.remove(r.firstWhere(
            (e) => ProductModel.fromJson(e).id == product.id,
          ));
        }
        return storage.setStringListByKey(
          key: PreferencesConstants.cartProducts,
          value: r,
        );
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> clean() {
    return storage.removeStringByKey(key: PreferencesConstants.cartProducts);
  }
}
