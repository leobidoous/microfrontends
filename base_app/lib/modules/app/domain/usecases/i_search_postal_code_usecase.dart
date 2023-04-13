
import 'package:core/core.dart';

import '../entities/postal_code_entity.dart';

abstract class ISearchPostalCodeUsecase {
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  });
}
