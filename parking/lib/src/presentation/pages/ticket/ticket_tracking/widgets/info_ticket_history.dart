import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/entities/dashboard/items_ticket_history_entity.dart';
import '../../../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../../controllers/ticket/ticket_history_controller.dart';

class TicketHistoryList extends StatefulWidget {
  final TicketHistoryController controller;
  final GlobalAuthController authController;
  const TicketHistoryList({
    super.key,
    required this.controller,
    required this.authController,
  });

  @override
  State<TicketHistoryList> createState() => _TicketHistoryListState();
}

class _TicketHistoryListState extends State<TicketHistoryList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TicketsHistoryEntity>(
      valueListenable: widget.controller,
      builder: (_, state, child) {
        if (widget.controller.isLoading) {
          return const Center(child: GenLoading());
        } else if (widget.controller.hasError) {
          return Center(
            child: RequestError(
              padding: const EdgeInsets.all(16),
              message: widget.controller.error.toString(),
              onPressed: () {
                widget.controller.fetchTicketHistory(
                  page: '0',
                  perPage: '10',
                );
              },
            ),
          );
        } else if (widget.controller.state.itemsTicketHistory!.isEmpty) {
          return Center(
            child: ListEmpty(
              asset: 'assets/images/wallet/transactions.svg',
              message: context.tr.notTransition,
              onPressed: () {},
              padding: const EdgeInsets.all(16),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: const Spacing(4).value,
                left: const Spacing(2).value,
              ),
              child: Text(
                context.tr.historyTicket,
                textAlign: TextAlign.left,
                style: context.textTheme.labelLarge?.copyWith(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: const Spacing(2).value,
              ),
              child: const Divider(),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: widget.controller.state.itemsTicketHistory!.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => Spacing.sm.vertical,
              itemBuilder: (_, index) {
                return _ticketHistoryListItem(
                  widget.controller.state.itemsTicketHistory![index],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _ticketHistoryListItem(ItemTicketHistoryEntity historyList) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              GenIcons.car,
              size: 25,
            ),
            Spacing.sm.horizontal,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyList.name!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: context.textTheme.fontWeightLight,
                    ),
                  ),
                  Spacing.xxs.vertical,
                  Text(
                    DateFormat.toDateTime(historyList.createdAt!),
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: context.textTheme.fontWeightRegular,
                      color: AppColorsBase.grey11,
                    ),
                  ),
                ],
              ),
            ),
            Spacing.sm.horizontal,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.toCurrency(historyList.valueSaved),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightRegular,
                  ),
                ),
                Spacing.xxs.vertical,
                SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: historyList.tipo != 'Pago'
                          ? context.colorScheme.primary
                          : null,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        width: context.theme.borderWidthXS,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Text(
                        historyList.tipo!,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: context.textTheme.fontWeightRegular,
                          fontSize: 12,
                          color: historyList.tipo != 'Pago'
                              ? GenColors.white
                              : context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
