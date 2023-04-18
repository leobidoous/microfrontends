import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../controllers/credit_card/remove_credit_card_controller.dart';
import 'confirm_remove_card.dart';

class DeleteCreditCard extends StatelessWidget {
  const DeleteCreditCard({
    super.key,
    required this.card,
    required this.onRemoveCard,
    required this.removeCardController,
  });

  final RemoveCreditCardController removeCardController;
  final CreditCardEntity card;
  final Function(String) onRemoveCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialog.show(
          context,
          ConfirmRemoveCard(
            card: card,
            onRemoveCard: onRemoveCard,
            removeCardController: removeCardController,
          ),
          showClose: true,
        );
      },
      child: Icon(
        CoreIcons.deleteOutline,
        color: AppColorsBase.grey7,
        size: const Spacing(2.5).value,
      ),
    );
  }
}
