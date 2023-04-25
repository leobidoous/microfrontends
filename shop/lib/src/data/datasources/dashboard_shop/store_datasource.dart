import 'package:core/core.dart';

import '../../../domain/entities/store_entity.dart';
import '../../../domain/entities/store_mall_entity.dart';
import '../../../infra/datasources/dashboard_shop/i_store_datasource.dart';
import '../../../infra/models/store_mall_model.dart';
import '../../../infra/models/store_model.dart';
import '../../../presentation/graphql/queries/shop_queries.dart';

class StoreDatasource implements IStoreDatasource {
  final IGraphQlDriver graphQlClient;

  StoreDatasource({
    required this.graphQlClient,
  });

  @override
  Future<Either<Exception, List<StoreEntity>>> fetchStores({
    required Map<String, dynamic> params,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: ShopQueries.listStores,
        variables: params,
      ),
    );

    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            ((r.data['listStores'] ?? []) as List)
                .map((e) => StoreModel.fromMap(e))
                .toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, List<StoreMallEntity>>> fetchStoreMalls() async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: ShopQueries.listStoreMalls,
      ),
    );

    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            ((r.data['listStoreMalls'] ?? []) as List)
                .map((e) => StoreMallModel.fromMap(e))
                .toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }
}
