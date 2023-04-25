import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:parking/parking.dart';
import 'package:shop/shop.dart';

import 'item_other_services.dart';

class ListOtherServices extends StatelessWidget {
  const ListOtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ItemOtherServices(
          title: 'Estacionamento',
          icon: CoreIcons.car,
          onTap: () => Nav.to.pushNamed(ParkingRoutes.root),
        ),
        ItemOtherServices(
          title: 'Lojas',
          icon: CoreIcons.building,
          onTap: () => Nav.to.pushNamed(ShopRoutes.root),
        ),
        ItemOtherServices(
          title: 'Campanhas',
          icon: CoreIcons.gift,
          onTap: () => CustomDialog.show(
            context,
            CustomAlert.noImplementation(context),
            showClose: true,
          ),
        ),
      ],
    );
  }
}
