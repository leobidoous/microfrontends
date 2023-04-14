import 'package:banner_carousel/banner_carousel.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/campaign_mall_entity.dart';
import '../../../controllers/dashboard_controller.dart';

class ListBanners extends StatelessWidget {
  const ListBanners({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CampaignMallEntity>>(
      valueListenable: controller,
      builder: (_, state, child) {
        return Container(
          width: double.infinity,
          height: const Spacing(19).value.responsiveHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BannerCarousel(
            animation: true,
            banners: controller.listBanners,
            margin: const EdgeInsets.all(0),
            spaceBetween: 2.0,
            width: double.infinity,
            height: const Spacing(15).value.responsiveHeight,
            activeColor: AppColorsBase.textButtonColor,
            disableColor: AppColorsBase.neutrla2,
            onTap: (id) {
              // if (id == '1') {
              //   Nav.to.pushNamed(Routes.EVENT_CAMPAIGN);
              // } else if (id == '2') {
              //   Nav.to.pushNamed(ParkingRoutes.root.completePath);
              // }
            },
          ),
        );
      },
    );
  }
}
