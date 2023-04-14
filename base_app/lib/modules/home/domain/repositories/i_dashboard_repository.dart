import 'package:core/core.dart';

import '../entities/campaign_mall_entity.dart';

abstract class IDashboardRepository {
  Future<Either<Exception, List<CampaignMallEntity>>> fetchCampaignMall({
    String? typeCampaign,
    required int idMall,
  });
}
