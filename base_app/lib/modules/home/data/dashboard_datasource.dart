import 'package:core/core.dart';

import '../domain/entities/campaign_mall_entity.dart';
import '../infra/datasource/i_dashboard_datasource.dart';
import '../infra/models/campaing_mall_model.dart';

class DashboardDatasource implements IDashboardDatasource {
  final String baseUrl;
  final IHttpDriver client;

  DashboardDatasource({
    required this.baseUrl,
    required this.client,
  });

  @override
  Future<Either<Exception, List<CampaignMallEntity>>> fetchCampaignMall({
    String? typeCampaign,
    required int idMall,
  }) async {
    final response = await client.get(
      baseUrl,
      queryParameters: {'type_campaign': typeCampaign, 'id_mall': idMall},
    );

    return response.fold(
      (l) => Left(Exception(l.statusMessage)),
      (r) {
        try {
          final campaignItens = (r.data['rows'] as List)
              .map((item) => CampaignMallModel.fromMap(item))
              .toList();
          return Right(campaignItens);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
