import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repositories/remove_product_from_cart_repository.dart';
import '../datasources/remove_product_from_cart_datasource.dart';

class RemoveProductFromCartRepository extends IRemoveProductFromCartRepository {
  final IRemoveProductFromCartDatasource datasource;

  RemoveProductFromCartRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call({required ProductEntity product}) {
    return datasource(product: product);
  }
}
