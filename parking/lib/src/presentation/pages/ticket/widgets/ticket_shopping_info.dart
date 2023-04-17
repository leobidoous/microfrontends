import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';

class TicketShoppingInfo extends StatelessWidget {
  const TicketShoppingInfo({super.key, required this.shopping});

  final ShoppingEntity shopping;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Tr.of(context).establishment,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: context.textTheme.fontWeightMedium,
          ),
        ),
        Spacing.sm.vertical,
        Container(
          decoration: BoxDecoration(
            color: AppColorsBase.grey2,
            border: Border.all(color: AppColorsBase.grey12),
            borderRadius: context.theme.borderRadiusSM,
          ),
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Row(
            children: [
              SizedBox(
                height: const Spacing(5).value,
                width: const Spacing(6).value,
                child: GenImage(
                  url: shopping.logoImage,
                  radius: context.theme.borderRadiusXSM,
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      shopping.name,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColorsBase.neutrla6,
                        fontWeight: context.textTheme.fontWeightRegular,
                      ),
                    ),
                    Spacing.xxs.vertical,
                    Text(
                      shopping.address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColorsBase.neutrla5,
                        fontWeight: context.textTheme.fontWeightLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
