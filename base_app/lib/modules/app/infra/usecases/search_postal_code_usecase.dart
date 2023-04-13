import 'package:core/core.dart';

import '../../domain/entities/postal_code_entity.dart';
import '../../domain/repositories/i_search_postal_code_repository.dart';
import '../../domain/usecases/i_search_postal_code_usecase.dart';

class SearchPostalCodeUsecase extends ISearchPostalCodeUsecase {
  final ISearchPostalCodeRepository repository;

  SearchPostalCodeUsecase({required this.repository});

  @override
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  }) {
    return repository(postalCode: postalCode);
  }
}
