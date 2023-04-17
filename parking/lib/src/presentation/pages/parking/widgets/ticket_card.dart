import 'package:barcode_widget/barcode_widget.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../controllers/parking/parking_coupon_controller.dart';
import 'shopping_location.dart';

Color statusTicketColor(int id) {
  switch (id) {
    case 1:
      //status em aberto
      return AppColorsBase.buttonColor; //.primary;
    case 2:
      //status pago
      return AppColorsBase.buttonColor; //.success;
    case 3:
      //status expirado
      return AppColorsBase.buttonColor; //.danger;
    default:
      return AppColorsBase.buttonColor; //.primary;
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.shopping,
    required this.controller,
    required this.onPayOrValidateTicket,
  });

  final TicketEntity ticket;
  final ShoppingEntity shopping;
  final Function() onPayOrValidateTicket;
  final ParkingCouponController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacing.sm.vertical,
        Text(
          Tr.of(context).ticketTitle,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        Spacing.md.vertical,
        MallLocation(
          shopping: shopping,
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(2).value,
            vertical: const Spacing(1).value,
          ),
        ),
        Spacing.md.vertical,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(2).value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Tempo',
                      style: context.textTheme.titleMedium,
                    ),
                    Spacing.xs.vertical,
                    Text(
                      DateFormat.toDateTime(ticket.entradaDatahora),
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Valor',
                      style: context.textTheme.titleMedium,
                    ),
                    Spacing.xs.vertical,
                    Text(
                      NumberFormat.toCurrency(ticket.valorTotal),
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Status',
                      style: context.textTheme.titleMedium,
                    ),
                    Spacing.xs.vertical,
                    Text(
                      ticket.status.status.capitalize,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: context.textTheme.fontWeightMedium,
                        color: statusTicketColor(ticket.status.code),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacing.md.vertical,
        const DashedDivider(),
        Spacing.sm.vertical,
        Container(
          padding: EdgeInsets.all(const Spacing(2).value),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColorsBase.grey2),
              top: BorderSide(color: AppColorsBase.grey2),
            ),
          ),
          child: RepaintBoundary(
            child: BarcodeWidget(
              height: const Spacing(7).value.responsiveHeight,
              barcode: ticket.isAean13 ? Barcode.ean13() : Barcode.itf(),
              data: ticket.ticket ?? '',
              errorBuilder: (context, error) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    GenIcons.car,
                    size: 17.0,
                    color: context.colorScheme.primary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: const Spacing(4).value),
                    child: Text(
                      (ticket.plate != null)
                          ? 'Placa ${ticket.plate}'
                          : 'Placa não localizada',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColorsBase.greyText02,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              drawText: false,
            ),
          ),
        ),
        Spacing.sm.vertical,
        const DashedDivider(),
        Spacing.md.vertical,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(2).value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  DateFormat.toDate(ticket.transacaoValidadeDatahora),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                child: Text(
                  DateFormat.toTime(ticket.transacaoValidadeDatahora),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                child: Text(
                  ticket.ticket ?? '',
                  textAlign: TextAlign.end,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        Spacing.sm.vertical,
        if (ticket.status.code == 1 || ticket.status.code == 3) ...[
          Padding(
            padding: EdgeInsets.all(const Spacing(2).value),
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                return GenButton.text(
                  text: (ticket.discount.percentOfDiscount == 1)
                      ? Tr.of(context).validateParking
                      : Tr.of(context).payTextButton,
                  type: ButtonType.tertiary,
                  isLoading: controller.isLoading,
                  isEnabled: !controller.hasError,
                  onPressed: onPayOrValidateTicket,
                );
              },
            ),
          ),
          Spacing.sm.vertical,
        ]
      ],
    );
  }
}
