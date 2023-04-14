import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/credit_card_entity.dart';
import '../../../../domain/enums/credit_card_type.dart';
import '../../../controllers/credit_card/remove_credit_card_controller.dart';
import '../../widgets/delete_credit_card.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    this.removeCardController,
    required this.onSelected,
    required this.card,
    this.onRemoveCard,
  });

  final RemoveCreditCardController? removeCardController;
  final Function(CreditCardEntity) onSelected;
  final Function(String)? onRemoveCard;
  final CreditCardEntity card;

  @override
  Widget build(BuildContext context) {
    return GenCard(
      shaddow: const [],
      onTap: () => onSelected(card),
      border: context.theme.borderZero,
      padding: EdgeInsets.all(const Spacing(1).value),
      child: Row(
        children: [
          Image.asset(
            card.brand.image,
            height: const Spacing(4).value.responsiveHeight,
            width: const Spacing(5).value.responsiveWidth,
            alignment: Alignment.centerLeft,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  card.brand.name.capitalize,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    color: AppColorsBase.neutrla7,
                  ),
                ),
                Spacing.xxs.vertical,
                Text(
                  '**** ${card.last4}',
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    color: AppColorsBase.neutrla4,
                  ),
                ),
              ],
            ),
          ),
          if (removeCardController != null && onRemoveCard != null) ...[
            Spacing.sm.horizontal,
            DeleteCreditCard(
              card: card,
              removeCardController: removeCardController!,
              onRemoveCard: onRemoveCard!,
            ),
          ]
        ],
      ),
    );
  }
}
