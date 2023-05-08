import 'package:core/core.dart';

import '../../entities/Institution_entity.dart';

abstract class IInstitutionRepository {

  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList();

}