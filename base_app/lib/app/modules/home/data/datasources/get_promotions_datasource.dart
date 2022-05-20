import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';
import '../../infra/datasources/get_promotions_datasource.dart';
import '../../infra/models/product_model.dart';

class GetPromotionsDatasource extends IGetPromotionsDatasource {
  final IHttpDriver httpDriver;

  GetPromotionsDatasource({required this.httpDriver});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() async {
    final response = await httpDriver.get('/promotions');
    return response.fold(
      (l) => Left(Exception('[${l.statusCode}] ${l.data}')),
      (r) {
        return Right(
          (r.data as List)
              .map((e) => ProductModel.fromMap(e).toEntity())
              .toList(),
        );
      },
    );
  }
}
