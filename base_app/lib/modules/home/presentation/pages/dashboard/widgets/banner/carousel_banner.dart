import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:parking/parking.dart';

import '../../../../../domain/entities/campaign_mall_entity.dart';
import '../../../../controllers/dashboard_controller.dart';
import '../../../../routes/home_routes.dart';
import 'animated_dot.dart';

class CarouselBanner extends StatefulWidget {
  const CarouselBanner({super.key, required this.controller});

  final DashboardController controller;

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  final controller = CarouselController();
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CampaignMallEntity>>(
      valueListenable: widget.controller,
      builder: (_, state, child) {
        if (state.isEmpty) return const SizedBox();
        return Column(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: state.length,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() => selected = index);
                },
                autoPlay: true,
                disableCenter: true,
                height: const Spacing(18).value,
                enlargeFactor: .2,
                viewportFraction: .9,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              itemBuilder: (context, index, realIndex) => _bannerItem(
                state[index],
              ),
            ),
            Spacing.xs.vertical,
            CustomScrollContent(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: context.kSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state
                      .map(
                        (e) => AnimatedDot(
                          callback: () {
                            setState(() {
                              selected = state.indexOf(e);
                            });
                            controller.animateToPage(
                              state.indexOf(e),
                            );
                          },
                          selected: selected == state.indexOf(e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Spacing.lg.vertical,
          ],
        );
      },
    );
  }

  Widget _bannerItem(CampaignMallEntity item) {
    return CustomCard(
      onTap: () {
        switch (item.id) {
          case 1:
            // Nav.to.pushNamed(Routes.EVENT_CAMPAIGN);
            break;
          default:
            Nav.to.pushNamed(
              HomeRoutes.root.concate([ParkingRoutes.root]),
              forRoot: true,
            );
            break;
        }
      },
      radius: context.theme.borderRadiusSM,
      child: ClipRRect(
        borderRadius: context.theme.borderRadiusSM,
        child: CustomImage(
          url: item.bannerUrl.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
