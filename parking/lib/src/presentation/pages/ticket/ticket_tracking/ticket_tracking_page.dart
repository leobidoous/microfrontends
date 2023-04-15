import 'dart:async';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../domain/enums/ticket_status_enum.dart';
import '../../../controllers/parking/parking_ticket_controller.dart';
import '../../../controllers/ticket/ticket_count_down_controller.dart';
import '../../../controllers/ticket/ticket_history_controller.dart';
import '../../../parking_routes.dart';
import '../../ticket/ticket_submit_page.dart';
import '../../ticket/widgets/ticket_card_details.dart';
import '../widgets/ticket_shopping_info.dart';
import 'ticket_tracking_empty_page.dart';
import 'widgets/info_ticket_history.dart';

part '../ticket_tracking/widgets/circular_indicator_timer.dart';
part 'widgets/info_shopping_tracking.dart';

class TicketTrackingPage extends StatefulWidget {
  const TicketTrackingPage({
    super.key,
  });

  @override
  State<TicketTrackingPage> createState() => _TicketTrackingPageState();
}

class _TicketTrackingPageState extends State<TicketTrackingPage> {
  final ticketHistoryController = DM.i.get<TicketHistoryController>();
  final controller = DM.i.get<ParkingTicketController>();
  final authController = DM.i.get<GlobalAuthController>();
  final shopping = DM.i.get<ShoppingModel>();

  @override
  void initState() {
    super.initState();
    controller.fecthInfoTicket(
      idShopping: shopping.id.toString(),
    );
    ticketHistoryController.fetchTicketHistory(
      page: '0',
      perPage: '100',
    );
  }

  @override
  void dispose() {
    ticketHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: context.tr.ticketTitle,
        showDivider: false,
        onBackTap: Nav.to.pop,
        actions: [
          AppBarButton(
            child: Icon(
              GenIcons.messageCircle,
              color: context.colorScheme.onBackground,
              size: const Spacing(3).value,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      body: ValueListenableBuilder<TicketEntity>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (controller.isLoading) {
            return const Center(child: GenLoading());
          } else if (controller.hasError) {
            return const TicketTrackingEmptyPage();
          }

          return ValueListenableBuilder<TicketEntity>(
            valueListenable: controller,
            builder: (context, state, child) {
              if (controller.isLoading) {
                return const Center(child: GenLoading());
              } else if (controller.hasError) {
                return const TicketTrackingEmptyPage();
              }

              return GenScrollContent(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: controller.state.plate != null,
                      child: Padding(
                        padding: EdgeInsets.all(const Spacing(1).value),
                        child: Card(
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                GenMeasures.borderRadius,
                              ),
                            ),
                          ),
                          child: ColoredBox(
                            color: GenColors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: GenMeasures.base * 1.2,
                                    top: GenMeasures.base * 1.2,
                                    bottom: GenMeasures.base * 1.2,
                                    right: GenMeasures.base / 1.2,
                                  ),
                                  child: Icon(
                                    GenIcons.car,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: const Spacing(5).value,
                                  child: VerticalDivider(
                                    width: 1,
                                    thickness: 2,
                                    color: GenColors.gray.withOpacity(0.1),
                                  ),
                                ),
                                Text(
                                  'Mercedes',
                                  style:
                                      context.textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Placa htj-8923',
                                  style: context.textTheme.bodySmall!
                                      .copyWith(color: GenColors.gray),
                                ),
                                Text(
                                  'CLA - 250',
                                  style: context.textTheme.bodySmall!
                                      .copyWith(color: GenColors.gray),
                                ),
                                SizedBox(width: const Spacing(2).value),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacing.sm.vertical,
                    _CircularIndicatorTimer(
                      entity: state,
                    ),
                    textCircularIndicator(state),
                    Spacing.sm.vertical,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: const Spacing(2).value,
                      ),
                      child: TicketShoppingInfo(shopping: shopping),
                    ),
                    Spacing.sm.vertical,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: const Spacing(2).value,
                      ),
                      child: TicketCardDetails(ticket: state),
                    ),
                    Spacing.sm.vertical,
                    if (ticketHistoryController.state.itemsTicketHistory !=
                            null &&
                        ticketHistoryController
                            .state.itemsTicketHistory!.isNotEmpty) ...{
                      Visibility(
                        visible:
                            ticketHistoryController.state.itemsTicketHistory !=
                                        null &&
                                    ticketHistoryController
                                        .state.itemsTicketHistory!.isNotEmpty
                                ? true
                                : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: const Spacing(3).value,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: const Spacing(2.5).value,
                                        ),
                                        child: Text(
                                          context.tr.historyValue,
                                          softWrap: true,
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppColorsBase.grey6,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        DateFormat.toDateTime(
                                          DateTime.now(),
                                        ),
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
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
                                          context.tr.amountSaved,
                                          softWrap: true,
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppColorsBase.grey6,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'R\$ ${NumberFormat.toCurrency(
                                          0,
                                          symbol: '',
                                        )}',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: const Spacing(1).value,
                              ),
                              child: TicketHistoryList(
                                controller: ticketHistoryController,
                                authController: authController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                    SizedBox(
                      height: Spacing.xxxl.height,
                    ),
                    showPaymentBottom()
                        ? SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: const Spacing(2).value,
                              ),
                              child: GenButton.text(
                                text: context.tr.continueButton,
                                type: ButtonType.tertiary,
                                onPressed: () {
                                  Nav.to.pushNamed(
                                    TicketRoutes.root,
                                    arguments: TicketSubmitPageArgs(
                                      ticketOrPlate:
                                          controller.state.ticket ?? '',
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
                              ),
                            ),
                          )
                        : const LimitedBox(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget textCircularIndicator(TicketEntity entity) {
    switch (entity.status.code) {
      case 0:
        return Padding(
          padding: EdgeInsets.only(top: const Spacing(0).value),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr.exitLimited,
                  style:
                      context.textTheme.headlineSmall!.copyWith(fontSize: 18),
                ),
                Text(
                  DateFormat.toTime(
                    entity.validadeDatahora,
                    pattern: 'HH:mm',
                  ),
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      case 1:
        return Padding(
          padding: EdgeInsets.only(top: const Spacing(0).value),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${context.tr.estimatedValue}: ',
                  style:
                      context.textTheme.headlineSmall!.copyWith(fontSize: 18),
                ),
                Text(
                  'R\$ ${NumberFormat.toCurrency(
                    entity.valorTotal,
                    symbol: '',
                  )}',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      case 2:
        return Padding(
          padding: EdgeInsets.only(top: const Spacing(0).value),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr.exitLimited,
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                  ),
                ),
                Text(
                  DateFormat.toTime(
                    entity.validadeDatahora,
                  ),
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      case 3:
        return Padding(
          padding: EdgeInsets.only(top: const Spacing(3).value),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr.outputLimitExceeded,
                  style:
                      context.textTheme.headlineSmall!.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      default:
        return Padding(
          padding: EdgeInsets.only(top: const Spacing(0).value),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr.exitLimited,
                  style:
                      context.textTheme.headlineSmall!.copyWith(fontSize: 18),
                ),
                Text(
                  DateFormat.toTime(
                    entity.validadeDatahora,
                    pattern: 'HH:mm',
                  ),
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  bool showPaymentBottom() {
    final cod = controller.state.status.code;
    return (cod == 1 || cod == 3);
  }
}
