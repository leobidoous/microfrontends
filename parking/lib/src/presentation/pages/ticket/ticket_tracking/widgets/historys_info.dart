import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/translations.dart';
import '../../../../../infra/models/ticket/history_ticket_model.dart';
import '../../../../controllers/ticket/tracking/ticket_history_controller.dart';

class HistorysInfo extends StatefulWidget {
  const HistorysInfo({super.key, this.activeSeeHistoryButton = false});
  final bool? activeSeeHistoryButton;

  @override
  State<HistorysInfo> createState() => _HistorysInfoState();
}

class _HistorysInfoState extends State<HistorysInfo> {
  final controller = DM.i.get<TicketHistoryController>();

  @override
  void initState() {
    super.initState();
    controller.fetchTicketHistory(page: '0', perPage: '100');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullAmountSaved = 0.0;

    return ValueListenableBuilder<List<HistoryTicketModel>>(
      valueListenable: controller,
      builder: (_, state, child) {
        if (controller.isLoading) {
          return const Center(child: CustomLoading());
        } else if (controller.hasError) {
          return Center(
            child: RequestError(
              padding: EdgeInsets.all(const Spacing(2).value),
              message: controller.error.toString(),
              onPressed: () {
                controller.fetchTicketHistory(
                  page: '0',
                  perPage: '10',
                );
              },
            ),
          );
        } else if (controller.state.isNotEmpty) {
          state.forEach(
            (element) => fullAmountSaved +=
                (double.tryParse(element.valorEconomizado ?? '0') ?? 0),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(3).value,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: const Spacing(2.5).value,
                          ),
                          child: Text(
                            Tr.of(context).historyValue,
                            softWrap: true,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColorsBase.grey6,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat.toDateTime(
                            state.first.createdAt,
                            pattern: 'dd/MM/yyyy - HH:mm',
                          ),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: const Spacing(2.5).value,
                          ),
                          child: Text(
                            Tr.of(context).amountSaved,
                            softWrap: true,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColorsBase.grey6,
                            ),
                          ),
                        ),
                        Text(
                          'R\$ ${NumberFormat.toCurrency(
                            fullAmountSaved,
                            symbol: '',
                          )}',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: const Spacing(4).value,
                  left: const Spacing(2).value,
                ),
                child: Text(
                  Tr.of(context).historyTicket,
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
                itemCount: controller.state.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(const Spacing(2).value),
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) {
                  return _ticketHistoryListItem(
                    controller.state[index],
                  );
                },
              ),
            ],
          );
        }
        return const LimitedBox();
      },
    );
  }

  Widget _ticketHistoryListItem(HistoryTicketModel history) {
    return Row(
      children: [
        // const Icon(
        //   CoreIcons.buildingCar,
        //   size: 25,
        // ),
        Spacing.sm.horizontal,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history.mall?.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightLight,
                ),
              ),
              Spacing.xxs.vertical,
              Text(
                DateFormat.toDateTime(history.createdAt!),
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
              NumberFormat.toCurrency(history.valorEconomizado),
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightRegular,
              ),
            ),
            Spacing.xxs.vertical,
            DecoratedBox(
              decoration: BoxDecoration(
                color:
                    history.tipo != 'Pago' ? context.colorScheme.primary : null,
                borderRadius: AppThemeBase.borderRadiusMD,
                border: Border.all(
                  width: context.theme.borderWidthXS,
                  color: context.colorScheme.primary,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: const Spacing(.5).value,
                  horizontal: const Spacing(1).value,
                ),
                child: Text(
                  history.tipo!,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: history.tipo != 'Pago'
                        ? context.colorScheme.background
                        : context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
