import 'package:core/core.dart';

import '../../domain/entities/campaign_mall_entity.dart';

abstract class IDashboardDatasource {
  Future<Either<Exception, List<CampaignMallEntity>>> fetchCampaignMall({
    String? typeCampaign,
    required int idMall,
  });
}
