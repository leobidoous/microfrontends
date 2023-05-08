import 'package:core/core.dart';

import '../../../domain/entities/Institution_entity.dart';

abstract class IInstitutionDatasource {
  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList();
}