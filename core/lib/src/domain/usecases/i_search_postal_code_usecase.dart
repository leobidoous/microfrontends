import '../entities/postal_code_entity.dart';
import '../interfaces/either.dart';

abstract class ISearchPostalCodeUsecase {
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  });
}
