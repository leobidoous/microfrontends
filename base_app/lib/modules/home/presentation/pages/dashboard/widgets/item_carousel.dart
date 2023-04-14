import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/campaign_mall_entity.dart';

class ItemCarousel extends StatelessWidget {
  const ItemCarousel({
    super.key,
    required this.campaign,
  });

  final CampaignMallEntity campaign;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: campaign.typeCampaign == 'GETMO'
      //     ? () => Nav.to.pushNamed(Routes.EVENT_CAMPAIGN, arguments: campaign)
      //     : campaign.typeCampaign == 'Parking-Free'
      //         ? () => Nav.to.pushNamed(ParkingRoutes.root.completePath)
      //         : () {},
      child: CachedNetworkImage(
        imageUrl: campaign.bannerUrl.url,
        imageBuilder: (context, imageProvider) => Container(
          width: 312,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
