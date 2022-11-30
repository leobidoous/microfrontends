import 'package:core/core.dart' show Either, HttpDriverResponse;

import '../entities/stocks_entity.dart';

abstract class IStocksRepository {
  Future<Either<HttpDriverResponse, StocksEntity>> getDetails({
    required String symbol,
  });
  Future<Either<HttpDriverResponse, List<StocksEntity>>> list({
    required String term,
  });
}
