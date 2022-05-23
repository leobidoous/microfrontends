import 'package:core/core.dart';

import '../../../../core/constants/preferences_constants.dart';
import '../../home/domain/entities/product_entity.dart';
import '../../home/infra/models/product_model.dart';
import '../infra/datasources/get_cart_products_datasource.dart';

class GetCartProductsDatasource extends IGetCartProductsDatasource {
  final IPreferencesStorageDriver storage;

  GetCartProductsDatasource({required this.storage});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() async {
    return storage
        .getStringListByKey(key: PreferencesConstants.cartProducts)
        .then(
      (value) {
        return value.fold(
          (l) => Left(l),
          (r) => Right(
            r.map((e) => ProductModel.fromJson(e).toEntity()).toList(),
          ),
        );
      },
    );
  }
}
