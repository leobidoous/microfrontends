import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../l10n/translations.dart';

class TalkWithUs extends StatelessWidget {
  final bool isSafeArea;
  const TalkWithUs({super.key, this.isSafeArea = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(2).value,
            vertical: const Spacing(3).value,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  Tr.of(context).canWeHelpYou,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightBold,
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
              LocalTheme.dark(
                builder: (context) {
                  return Text(
                    Tr.of(context).contactSupport,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: AppColorsBase.grey3),
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(2).value,
            vertical: const Spacing(3).value,
          ),
          child: SafeArea(
            bottom: isSafeArea,
            child: GenButton.iconText(
              onPressed: () => DM.i.get<ZendeskController>().openChat(),
              text: Tr.of(context).contactUs,
              type: ButtonType.background,
              icon: GenIcons.messageCircle,
            ),
          ),
        )
      ],
    );
  }
}
