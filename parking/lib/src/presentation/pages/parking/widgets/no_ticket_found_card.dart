import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../routes/parking_routes.dart';
import '../../../routes/ticket_routes.dart';
import '../../ticket/ticket_submit_page.dart';

class NoTicketFoundCard extends StatelessWidget {
  const NoTicketFoundCard({
    super.key,
    this.onRefresh,
    required this.isEnabled,
  });

  final bool isEnabled;
  final VoidCallback? onRefresh;

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
        GenButton.text(
          text: Tr.of(context).scanTicketButton,
          onPressed: () async {
            await Nav.to.pushNamed(
              ParkingRoutes.scanBardCode,
              arguments: (code) async {
                await Nav.to.pushReplacementNamed(
                  TicketRoutes.root,
                  arguments: TicketSubmitPageArgs(
                    ticketOrPlate: code,
                    onPop: () {
                      Nav.to.popUntil(
                        ModalRoute.withName(
                          ParkingRoutes.root.completePath,
                        ),
                      );
                    },
                  ),
                );
              },
            ).then((_) => onRefresh?.call());
          },
        ),
        Spacing.md.vertical,
        GenButton.text(
          text: Tr.of(context).typePlate,
          type: ButtonType.background,
          isEnabled: isEnabled,
          onPressed: () async {
            await Nav.to
                .pushNamed(ParkingRoutes.addTicketByPlate)
                .then((value) => onRefresh?.call());
          },
        ),
        Spacing.xs.vertical,
      ],
    );
  }
}
