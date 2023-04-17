import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../controllers/ticket/ticket_submit_controller.dart';
import 'ticket_shopping_info.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({
    super.key,
    required this.shopping,
    required this.controller,
  });

  final ShoppingEntity shopping;
  final TicketSubmitController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TicketEntity>(
      valueListenable: controller,
      builder: (context, ticket, child) {
        if (controller.isLoading) {
          return Column(
            children: [
              GenShimmer(
                height: const Spacing(1.5).value,
                width: const Spacing(30).value,
              ),
              Spacing.xs.vertical,
              GenShimmer(
                height: const Spacing(1.5).value,
                width: const Spacing(15).value,
              ),
            ],
          );
        } else if (controller.hasError) {
          return Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Erro no servidor\n',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightMedium,
              ),
              children: [
                TextSpan(
                  text:
                      '''Serviço temporariamente indisponível.\nTente novamente mais tarde.''',
                  style: context.textTheme.bodyMedium,
                )
              ],
            ),
          );
        }

        final discount = ticket.discount.percentOfDiscount;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ticket.discount.hasDescont)
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Pague seu estacionamento \ncom ',
                  style: context.textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: '${(discount * 100).round()}% de desconto',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: context.textTheme.fontWeightMedium,
                      ),
                    ),
                  ],
                ),
              ),
            if (!ticket.discount.hasDescont)
              Text(
                Tr.of(context).offDiscount,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
              ),
            Spacing.md.vertical,
            TicketShoppingInfo(shopping: shopping),
          ],
        );
      },
    );
  }
}
