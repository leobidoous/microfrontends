import 'package:core/core.dart';

import '../../../domain/entities/Institution_entity.dart';
import '../../../domain/repositories/institution/i_institution_repository.dart';
import '../../../domain/usecase/institution/i_institution_usecase.dart';

class InstitutionUsecase extends IInstitutionUsecase {

  final IInstitutionRepository repository;
  
  InstitutionUsecase({
    required this.repository,
  });

  @override
  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList() {
    return repository.fetchBankList();
  }
}