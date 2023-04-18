import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../routes/vehicles_routes.dart';

class NoTicketFoundCard extends StatelessWidget {
  const NoTicketFoundCard({
    super.key,
    required this.onRefresh,
    required this.isEnabled,
    required this.onScanTicket,
  });

  final bool isEnabled;
  final Function() onRefresh;
  final Function() onScanTicket;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Tr.of(context).ticketTitle,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: context.textTheme.fontWeightBold,
          ),
        ),
        Spacing.md.vertical,
        Text(
          Tr.of(context).ticketNotFound,
          textAlign: TextAlign.center,
          style: context.textTheme.labelLarge,
        ),
        Spacing.md.vertical,
        CustomButton.text(
          text: Tr.of(context).scanTicketButton,
          onPressed: onScanTicket,
        ),
        Spacing.md.vertical,
        CustomButton.text(
          text: Tr.of(context).typePlate,
          type: ButtonType.background,
          isEnabled: isEnabled,
          onPressed: () async {
            await Nav.to
                .pushNamed(VehiclesRoutes.enterPlateNumber)
                .then((value) => onRefresh());
          },
        ),
        Spacing.xs.vertical,
      ],
    );
  }
}
