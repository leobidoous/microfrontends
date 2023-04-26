import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../pay_routes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.isLinkC,
    required this.goToParking,
  });

  final bool isLinkC;
  final Function() goToParking;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pagamento'),
      body: SafeArea(
        child: CustomScrollContent(
          padding: EdgeInsets.all(const Spacing(3).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'O que deseja pagar?',
                style: context.textTheme.titleMedium,
              ),
              Spacing.md.vertical,
              CustomWrap(
                nCols: 2,
                items: [
                  wrapItem(
                    title: 'Estacionamento',
                    icon: CoreIcons.car,
                    soon: !widget.isLinkC,
                    onTap: widget.goToParking,
                  ),
                  wrapItem(
                    title: 'Realizar recarga',
                    icon: CoreIcons.phone,
                    soon: !widget.isLinkC,
                    onTap: () => Nav.to.pushNamed(PayRoutes.phoneRecharge),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wrapItem({
    required String title,
    required IconData icon,
    required bool soon,
    required Function() onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      padding: EdgeInsets.all(const Spacing(2).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: context.colorScheme.primary,
          ),
          Spacing.sm.vertical,
          Text(
            title,
            maxLines: 2,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
