import 'package:core/core.dart';

import '../../domain/entities/campaign_mall_entity.dart';
import '../../domain/repositories/i_dashboard_repository.dart';
import '../datasource/i_dashboard_datasource.dart';

class DashboardRepository implements IDashboardRepository {
  final IDashboardDatasource datasource;

  DashboardRepository({
    required this.datasource,
  });

  @override
  Future<Either<Exception, List<CampaignMallEntity>>> fetchCampaignMall({
    String? typeCampaign,
    required int idMall,
  }) async {
    return await datasource.fetchCampaignMall(
      typeCampaign: typeCampaign,
      idMall: idMall,
    );
  }
}
