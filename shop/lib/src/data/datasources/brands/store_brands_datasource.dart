import 'package:core/core.dart';

import '../../../domain/entities/store_brand_entity.dart';
import '../../../infra/datasources/brands/i_store_brands_datasource.dart';
import '../../../infra/models/store_brand_model.dart';
import '../../../presentation/graphql/queries/shop_queries.dart';

class StoreBrandsDataSource implements IStoreBrandsDatasource {
  final IGraphQlDriver graphQlClient;

  StoreBrandsDataSource({
    required this.graphQlClient,
  });

  @override
  Future<Either<Exception, List<StoreBrandEntity>>> fetchStoreBrands({
    required Map<String, dynamic> params,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: ShopQueries.listStoreBrands,
        variables: params,
      ),
    );

    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            ((r.data['listStoreBrands'] ?? []) as List)
                .map((e) => StoreBrandModel.fromMap(e))
                .toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }
}
