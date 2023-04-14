import 'package:banner_carousel/banner_carousel.dart';
import 'package:core/core.dart';

import '../../domain/entities/campaign_mall_entity.dart';
import '../../domain/usecases/i_dashboard_usecase.dart';

class DashboardController
    extends GenController<Exception, List<CampaignMallEntity>> {
  DashboardController({
    required this.dashboardUsecase,
    required notificationsController,
  }) : super([]);

  IDashboardUsecase dashboardUsecase;

  List<BannerModel> listBanners = <BannerModel>[];
  bool isCouponEnabled = false;
  bool isLinkC = true;
  Map<String, dynamic> campaignClosestMallByLocation = {};
  bool get getIsLinkC =>
      campaignClosestMallByLocation['closestMallId'] != 12 &&
      campaignClosestMallByLocation['closestMallId'] != 13;

  Future<void> fetchCampaignMall() async {
    listBanners
      ..clear()
      ..add(
        BannerModel(
          id: '1',
          imagePath:
              'https://firebasestorage.googleapis.com/v0/b/neru-teste.appspot.com/o/events%2Fgetmo%2Fbanner_default_getmo.jpg?alt=media&token=84dd11fa-22b9-4aab-99c3-68ecbe412764',
        ),
      );

    campaignClosestMallByLocation = {};

    if (campaignClosestMallByLocation.isNotEmpty) {
      if (getIsLinkC) {
        isCouponEnabled = true;
        await execute(() {
          return dashboardUsecase
              .fetchCampaignMall(
                typeCampaign: 'Parking-Free',
                idMall: campaignClosestMallByLocation['closestMallId'],
              )
              .then(
                (value) => value.fold((l) => Left(l), (r) {
                  listBanners.add(
                    BannerModel(
                      id: '2',
                      imagePath: r[0].bannerUrl.url,
                    ),
                  );
                  return Right(r);
                }),
              );
        });
      } else {
        isLinkC = false;
      }
    }
  }
}
