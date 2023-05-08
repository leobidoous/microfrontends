import 'package:core/core.dart';

import '../../entities/Institution_entity.dart';

abstract class IInstitutionUsecase {

  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList();

}