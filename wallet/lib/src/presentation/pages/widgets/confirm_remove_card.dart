import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/enums/credit_card_type.dart';
import '../../controllers/credit_card/remove_credit_card_controller.dart';

class ConfirmRemoveCard extends StatelessWidget {
  final CreditCardEntity card;
  final Function(String) onRemoveCard;
  final RemoveCreditCardController removeCardController;

  const ConfirmRemoveCard({
    super.key,
    required this.card,
    required this.onRemoveCard,
    required this.removeCardController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.colorScheme.tertiaryContainer,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    card.brand.image,
                    height: 20.responsiveHeight,
                    width: 30.responsiveWidth,
                  ),
                  Spacing.sm.horizontal,
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.brand.name.capitalize,
                          style: context.textTheme.bodyMedium,
                        ),
                        Spacing.xxs.vertical,
                        Text(
                          '**** ${card.last4}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Spacing.sm.vertical,
        Text(
          'Excluir este cartão?',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall,
        ),
        Spacing.sm.vertical,
        Text(
          'Essa ação não pode ser desfeita.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge,
        ),
        Spacing.sm.vertical,
        ValueListenableBuilder(
          valueListenable: removeCardController,
          builder: (_, state, child) {
            return GenButton.text(
              text: 'Sim, excluir',
              onPressed: () async {
                await onRemoveCard(card.id);
              },
              isLoading: removeCardController.isLoading,
            );
          },
        ),
      ],
    );
  }
}
