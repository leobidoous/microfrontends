import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/transaction_entity.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final label = transaction.seller.displayName.isNotEmpty
        ? transaction.seller.displayName
        : '-';

    return GenCard(
      shaddow: const [],
      border: context.theme.borderZero,
      padding: EdgeInsets.all(const Spacing(1).value),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColorsBase.neutrla0,
              borderRadius: BorderRadius.circular(
                const Spacing(0.5).value,
              ),
            ),
            width: const Spacing(5).value.responsiveWidth,
            height: const Spacing(5).value.responsiveHeight,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/wallet/transaction_item.svg',
              width: const Spacing(3).value.responsiveWidth,
              height: const Spacing(3).value.responsiveHeight,
              color: AppColorsBase.neutrla4,
            ),
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.capitalize,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                  ),
                ),
                Spacing.xxs.vertical,
                Text(
                  '${DateFormat.toTime(
                    transaction.insertedAt,
                    pattern: 'HH:mm',
                  )} - '
                  '${DateFormat.toDate(
                    transaction.insertedAt,
                    pattern: 'dd/MM/yy',
                  )}',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightRegular,
                    color: AppColorsBase.grey11,
                  ),
                ),
              ],
            ),
          ),
          Spacing.sm.horizontal,
          Text(
            NumberFormat.toCurrency(transaction.totalCents / 100),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: context.textTheme.fontWeightMedium,
              color: AppColorsBase.neutrla5,
            ),
          ),
        ],
      ),
    );
  }
}
