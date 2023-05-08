import 'package:core/core.dart';

import '../../../domain/entities/Institution_entity.dart';
import '../../../domain/repositories/institution/i_institution_repository.dart';
import '../../datasources/institution/i_institution_datasource.dart';

class InstitutionRepository extends IInstitutionRepository {

  final IInstitutionDatasource datasource;

  InstitutionRepository({
    required this.datasource,
  });

  @override
  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList() {
    return datasource.fetchBankList();
  }

}