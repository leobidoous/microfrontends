import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../controllers/dashboard_controller.dart';
import 'item_main_services.dart';

class ListMainServicesWidgets extends StatelessWidget {
  final controller = DM.i.get<DashboardController>();

  ListMainServicesWidgets({
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
          onTap: () => GenDialog.show(
            context,
            GenAlert.noImplementation(
              context,
            ),
            showClose: true,
          ),
        ),
        const ItemMainServices(
          title: 'Nas lojas',
          icon: CoreIcons.shop,
          // onTap: () => Nav.to.pushNamed(
          //   Routes.IN_SHOPS,
          //   arguments: controller.isCouponEnabled,
          // ),
        ),
        const ItemMainServices(
          title: 'Pagamentos',
          icon: CoreIcons.coinsAlt,
          // onTap: () => Nav.to.pushNamed(
          //   Routes.PAYMENT_OPTIONS,
          //   arguments: controller.isLinkC.value,
          // ),
        ),
      ],
    );
  }
}
