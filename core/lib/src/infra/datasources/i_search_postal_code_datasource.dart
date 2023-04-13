import '../../domain/entities/postal_code_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class ISearchPostalCodeDatasource {
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  });
}
