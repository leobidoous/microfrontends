import 'package:core/core.dart';

import '../../../../../core/constants/preferences_constants.dart';
import '../../domain/entities/product_entity.dart';
import '../../infra/datasources/add_product_to_cart_datasource.dart';
import '../../infra/models/product_model.dart';

class AddProductToCartDatasource extends IAddProductToCartDatasource {
  final IPreferencesStorageDriver storage;

  AddProductToCartDatasource({required this.storage});

  @override
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  }) async {
    final response = await storage.getStringListByKey(
      key: PreferencesConstants.cartProducts,
    );
    final products = [ProductModel.fromEntity(product).toJson()];
    return response.fold(
      (l) => Left(l),
      (r) {
        products.addAll(r);
        return storage.setStringListByKey(
          key: PreferencesConstants.cartProducts,
          value: products,
        );
      },
    );
  }
}
