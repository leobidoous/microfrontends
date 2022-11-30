import 'package:core/core.dart' show Either, HttpDriverResponse;

import '../entities/stocks_entity.dart';
import '../repositories/stocks_repository.dart';

abstract class IStocksUsecase {
  Future<Either<HttpDriverResponse, StocksEntity>> getDetails({
    required String symbol,
  });
  Future<Either<HttpDriverResponse, List<StocksEntity>>> list({
    required String term,
  });
}

class StocksUsecase extends IStocksUsecase {
  final IStocksRepository repository;

  StocksUsecase({required this.repository});

  @override
  Future<Either<HttpDriverResponse, StocksEntity>> getDetails({
    required String symbol,
  }) {
    return repository.getDetails(symbol: symbol);
  }

  @override
  Future<Either<HttpDriverResponse, List<StocksEntity>>> list({
    required String term,
  }) {
    return repository.list(term: term);
  }
}
