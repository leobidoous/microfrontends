import 'package:core/core.dart' show Either, HttpDriverResponse;

import '../../domain/entities/stocks_entity.dart';
import '../../domain/repositories/stocks_repository.dart';
import '../datasources/stocks_datasource.dart';

class StocksRepository extends IStocksRepository {
  final IStocksDatasource datasource;

  StocksRepository({required this.datasource});

  @override
  Future<Either<HttpDriverResponse, StocksEntity>> getDetails({
    required String symbol,
  }) {
    return datasource.getDetails(symbol: symbol);
  }

  @override
  Future<Either<HttpDriverResponse, List<StocksEntity>>> list({
    required String term,
  }) {
    return datasource.list(term: term);
  }
}
