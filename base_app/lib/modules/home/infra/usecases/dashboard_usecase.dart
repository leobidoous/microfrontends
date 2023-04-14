import 'package:core/core.dart';

import '../../domain/entities/campaign_mall_entity.dart';
import '../../domain/repositories/i_dashboard_repository.dart';
import '../../domain/usecases/i_dashboard_usecase.dart';

class DashboardUsecase implements IDashboardUsecase {
  final IDashboardRepository repository;

  DashboardUsecase({
    required this.repository,
  });

  /// Retornas as campanhas ativas conforme o shopping mais
  /// próximo da localização do usuário
  @override
  Future<Either<Exception, List<CampaignMallEntity>>> fetchCampaignMall({
    String? typeCampaign,
    required int idMall,
  }) async {
    return await repository.fetchCampaignMall(
      typeCampaign: typeCampaign,
      idMall: idMall,
    );
  }
}
