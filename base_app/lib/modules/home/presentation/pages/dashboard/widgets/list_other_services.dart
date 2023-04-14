import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'item_other_services.dart';

class ListOtherServicesWidgets extends StatelessWidget {
  const ListOtherServicesWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ItemOtherServices(
          title: 'Estacionamento',
          icon: GenIcons.car,
          // onTap: () => Nav.to.pushNamed(ParkingRoutes.root.completePath),
        ),
        ItemOtherServices(
          title: 'Lojas',
          icon: GenIcons.building,
          onTap: () => GenDialog.show(
            context,
            GenAlert.noImplementation(
              context,
            ),
            showClose: true,
          ),
          //onTap: () => Nav.to.pushNamed(Routes.STORES_PAGE),
        ),
        ItemOtherServices(
          title: 'Campanhas',
          icon: GenIcons.gift,
          onTap: () => GenDialog.show(
            context,
            GenAlert.noImplementation(
              context,
            ),
            showClose: true,
          ),
        ),
      ],
    );
  }
}
