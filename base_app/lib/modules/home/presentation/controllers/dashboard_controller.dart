import 'package:core/core.dart';

import '../../domain/entities/campaign_mall_entity.dart';
import '../../domain/entities/mall_file_entity.dart';
import '../../domain/usecases/i_dashboard_usecase.dart';

class DashboardController
    extends GenController<Exception, List<CampaignMallEntity>> {
  DashboardController({
    required this.dashboardUsecase,
    required notificationsController,
  }) : super([]);

  IDashboardUsecase dashboardUsecase;

  Map<String, dynamic> campaignClosest = {};
  bool isCouponEnabled = false;
  bool isLinkC = true;

  bool get _isLinkC =>
      campaignClosest['closestMallId'] != 12 &&
      campaignClosest['closestMallId'] != 13;

  Future<void> fetchCampaignMall() async {
    campaignClosest = {
      'closesMallAddress': 'Industrial da Serra Ouro. Alexânia - GO',
      'closesMallName': 'Outlet Premium Brasília',
      'closestMallDistance': 112486.56429895831,
      'closestMallId': 8,
    };
    const motherCampaign = CampaignMallEntity(
      id: 1,
      title: '',
      description: '',
      dateBegin: '',
      dateEnd: '',
      bannerUrl: MallFileEntity(
        id: 1,
        url:
            '''https://firebasestorage.googleapis.com/v0/b/neru-teste.appspot.com/o/events%2Fgetmo%2Fbanner_default_getmo.jpg?alt=media&token=84dd11fa-22b9-4aab-99c3-68ecbe412764''',
        path: '',
      ),
      shoppingId: 1,
      typeCampaign: '',
      rules: '',
    );

    setLoading(true);
    if (campaignClosest.isNotEmpty) {
      if (_isLinkC) {
        isCouponEnabled = true;
        final response = await dashboardUsecase.fetchCampaignMall(
          typeCampaign: 'Parking-Free',
          idMall: campaignClosest['closestMallId'],
        );
        return response.fold((l) {
          update([motherCampaign]);
        }, (r) {
          update([motherCampaign, ...r]);
        });
      } else {
        isLinkC = false;
        setLoading(false);
      }
    } else {
      setLoading(false);
    }
    update([motherCampaign]);
  }
}
