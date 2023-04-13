import 'package:core/core.dart';

import '../../domain/entities/postal_code_entity.dart';

abstract class ISearchPostalCodeDatasource {
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  });
}
