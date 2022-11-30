import 'package:core/core.dart'
    show Either, HttpDriverResponse, IHttpDriver, Left, Right;

import '../../domain/entities/stocks_entity.dart';
import '../../infra/datasources/stocks_datasource.dart';

class StocksDatasource extends IStocksDatasource {
  final IHttpDriver client;

  StocksDatasource({required this.client});

  @override
  Future<Either<HttpDriverResponse, StocksEntity>> getDetails({
    required String symbol,
  }) async {
    final response = await client.get(
      '/finances/search/',
      queryParameters: {
        'q': symbol,
      },
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        return Right(
          StocksEntity(
            id: 'id',
            name: 'name',
            symbol: 'symbol',
          ),
        );
      },
    );
  }

  @override
  Future<Either<HttpDriverResponse, List<StocksEntity>>> list({
    required String term,
  }) async {
    final response = await client.get(
      '/finances/search/',
      queryParameters: {
        'q': term,
      },
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        return const Right(
          []
        );
      },
    );
  }
}
