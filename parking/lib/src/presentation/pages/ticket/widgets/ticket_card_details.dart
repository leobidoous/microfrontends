import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/dashboard/ticket_entity.dart';

class TicketCardDetails extends StatefulWidget {
  const TicketCardDetails({
    super.key,
    required this.ticket,
    this.isLoading = false,
    this.hasError = false,
  });

  final TicketEntity ticket;
  final bool isLoading;
  final bool hasError;

  @override
  State<TicketCardDetails> createState() => _TicketCardDetailsState();
}

class _TicketCardDetailsState extends State<TicketCardDetails> {
  late Duration diff;
  late DateTime time;
  final dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    diff = dateNow.difference(widget.ticket.entradaDatahora);
    time = DateTime(
      0,
      0,
      0,
      diff.inSeconds ~/ 3600,
      (diff.inSeconds % 3600) ~/ 60,
      diff.inSeconds % 60,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Informações',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _label('Entrada'),
                              Spacing.xs.vertical,
                              _hour(widget.ticket.entradaDatahora),
                              Spacing.xs.vertical,
                              _label(
                                DateFormat.toDate(
                                  widget.ticket.entradaDatahora,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacing.sm.horizontal,
                        const Icon(Icons.arrow_forward_rounded),
                        Spacing.sm.horizontal,
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _label('Saída'),
                        Spacing.xs.vertical,
                        _hour(dateNow),
                        Spacing.xs.vertical,
                        _label(DateFormat.toDate(dateNow)),
                      ],
                    ),
                  ),
                ],
              ),
              Spacing.lg.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: const Spacing(2).value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _label('Tempo'),
                          Spacing.xs.vertical,
                          _value(time),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.ticket.discount.percentOfDiscount > 0)
                          Text.rich(
                            TextSpan(
                              text: 'Valor ',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: AppColorsBase.neutrla6,
                                fontWeight: context.textTheme.fontWeightRegular,
                              ),
                              children: [
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '''com desconto ${(widget.ticket.discount.percentOfDiscount * 100).round()}%''',
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                        color: AppColorsBase.neutrla6,
                                        fontWeight:
                                            context.textTheme.fontWeightMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (widget.ticket.discount.percentOfDiscount == 0)
                          Row(
                            children: [
                              Expanded(
                                child: (widget.ticket.status.code == 1)
                                    ? _label('Valor atual')
                                    : _label('Valor adicional'),
                              ),
                              Spacing.xs.horizontal,
                              InkWell(
                                onTap: () {
                                  GenDialog.show(
                                    context,
                                    GenAlert.paymentMethodWarning(context),
                                    showClose: true,
                                  );
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  size: const Spacing(2).value,
                                  color: AppColorsBase.grey7,
                                ),
                              )
                            ],
                          ),
                        Spacing.xs.vertical,
                        _price(
                          widget.ticket.valorDevido,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.ticket.status.code == 3) ...[
                Spacing.lg.vertical,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _label('Valor pago'),
                    Spacing.xs.vertical,
                    _price(widget.ticket.valorPago),
                  ],
                ),
              ],
              if (widget.ticket.discount.hasDescont) ...[
                Spacing.lg.vertical,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _label('Valor atual'),
                    Spacing.xs.vertical,
                    _price(widget.ticket.valorAdquirente),
                  ],
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String label) {
    return Text(
      label,
      style: context.textTheme.labelMedium?.copyWith(
        color: AppColorsBase.neutrla6,
        fontWeight: context.textTheme.fontWeightRegular,
      ),
    );
  }

  Widget _value(DateTime time) {
    if (widget.isLoading) {
      return GenShimmer(height: const Spacing(2.5).value);
    }
    return Text(
      DateFormat.toTime(time, pattern: 'HH:mm:ss'),
      style: context.textTheme.labelMedium?.copyWith(
        fontSize: const Spacing(2.25).value,
      ),
    );
  }

  Widget _hour(DateTime time) {
    if (widget.isLoading) {
      return GenShimmer(height: const Spacing(2.5).value);
    }
    return Text.rich(
      TextSpan(
        style: context.textTheme.labelMedium?.copyWith(
          fontSize: const Spacing(2.25).value,
        ),
        text: DateFormat.toTime(time, pattern: 'HH'),
        children: [
          TextSpan(
            children: [
              TextSpan(
                text: 'h',
                style: context.textTheme.labelMedium,
              ),
              TextSpan(text: DateFormat.toTime(time, pattern: 'mm')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _price(String price, {Color? color}) {
    if (widget.isLoading) {
      return GenShimmer(height: const Spacing(2.5).value);
    }
    return Text.rich(
      TextSpan(
        text: 'R\$',
        style: context.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: context.textTheme.fontWeightRegular,
        ),
        children: [
          TextSpan(
            children: [
              TextSpan(
                text: NumberFormat.toCurrency(price, symbol: ''),
                style: context.textTheme.labelMedium?.copyWith(
                  color: color,
                  fontSize: const Spacing(2.25).value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
