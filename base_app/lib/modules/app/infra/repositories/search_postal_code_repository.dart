
import 'package:core/core.dart';

import '../../domain/entities/postal_code_entity.dart';
import '../../domain/repositories/i_search_postal_code_repository.dart';
import '../datasources/i_search_postal_code_datasource.dart';

class SearchPostalCodeRepository extends ISearchPostalCodeRepository {
  final ISearchPostalCodeDatasource datasource;

  SearchPostalCodeRepository({required this.datasource});

  @override
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  }) {
    return datasource(postalCode: postalCode);
  }
}
