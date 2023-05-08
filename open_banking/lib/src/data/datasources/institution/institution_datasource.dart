
import 'package:core/core.dart';

import '../../../domain/entities/Institution_entity.dart';
import '../../../infra/datasources/institution/i_institution_datasource.dart';
import '../../../infra/models/institution_model.dart';
import '../../../presentation/graphql/queries/institution_queries.dart';

class InstitutionDatasource extends IInstitutionDatasource {
  
  InstitutionDatasource({
    required this.graphQlClient,
  });

  final IGraphQlDriver graphQlClient;
  
   @override
  Future<Either<Exception, List<InstitutionEntity>>> fetchBankList() async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: InstitutionQueries.listOpenBankingInstitutions,
      ),
    );
    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            r.data['listOpenBankingInstitutions']
            .map<InstitutionModel>((e) => InstitutionModel.fromMap(e)).toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e, $s'));
        }
      }
    );
  }
  
}