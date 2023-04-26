import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:parking/parking.dart';
import 'package:pay/pay.dart';
import 'package:shop/shop.dart';

import '../../../controllers/dashboard_controller.dart';
import 'item_main_services.dart';

class ListMainServices extends StatelessWidget {
  final controller = DM.i.get<DashboardController>();

  ListMainServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ItemMainServices(
          title: 'Comprar',
          icon: CoreIcons.carShopping,
          onTap: () => Nav.to.pushNamed(ShopRoutes.root),
        ),
        const ItemMainServices(
          title: 'Nas lojas',
          icon: CoreIcons.shop,
        ),
        ItemMainServices(
          title: 'Pagamentos',
          icon: CoreIcons.coinsAlt,
          onTap: () => Nav.to.pushNamed(
            PayRoutes.root,
            arguments: {
              'isLinkC': controller.isLinkC,
              'goToParking': () {
                Nav.to.pushNamed(ParkingRoutes.root);
              }
            },
          ),
        ),
      ],
    );
  }
}
