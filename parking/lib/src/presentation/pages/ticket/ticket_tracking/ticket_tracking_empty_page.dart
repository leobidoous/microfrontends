import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_assets.dart';
import '../../../../../l10n/translations.dart';
import '../../../../../parking.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../controllers/parking/parking_controller.dart';
import '../../../controllers/ticket/tracking/ticket_history_controller.dart';
import '../../../routes/ticket_routes.dart';
import '../ticket_submit/ticket_submit_page.dart';
import 'widgets/info_ticket_history.dart';

class TicketTrackingEmptyPage extends StatefulWidget {
  const TicketTrackingEmptyPage({super.key});

  @override
  State<TicketTrackingEmptyPage> createState() =>
      _TicketTrackingEmptyPageState();
}

class _TicketTrackingEmptyPageState extends State<TicketTrackingEmptyPage> {
  final fetchTicketHistoryController = DM.i.get<TicketHistoryController>();
  final authController = DM.i.get<SessionEntity>();
  final controller = DM.i.get<ParkingController>();

  // final shopping = DM.i.get<ShoppingModel>();
  bool viewHistory = false;

  @override
  void initState() {
    super.initState();
    controller.ticketController.fecthInfoTicket(
      idShopping: '1', //shopping.id.toString(),
    );
    fetchTicketHistoryController.fetchTicketHistory(page: '0', perPage: '100');
  }

  @override
  void dispose() {
    fetchTicketHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<TicketEntity>(
        valueListenable: controller.ticketController,
        builder: (context, state, child) {
          if (controller.isLoading) {
            return const Center(child: CustomLoading());
          } else if (controller.hasError) {
            return Center(
              child: RequestError(message: controller.error.toString()),
            );
          }
          return CustomScrollContent(
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: const Spacing(4).value),
                    child: Center(
                      child: Text(
                        Tr.of(context).notFoundTicket,
                        style: context.textTheme.headlineSmall!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(const Spacing(2).value),
                    child: SvgPicture.asset(
                      CustomAssets.ticketEmpty,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: const Spacing(2).value,
                      horizontal: const Spacing(2).value,
                    ),
                    child: CustomButton.text(
                      onPressed: () {
                        Nav.to.pushNamed(
                          ParkingRoutes.scanTicket,
                          arguments: (code) {
                            Nav.to.pushReplacementNamed(
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
                        );
                      },
                      text: Tr.of(context).scanTicketButton,
                    ),
                  ),
                  ValueListenableBuilder<TicketsHistoryEntity>(
                    valueListenable: fetchTicketHistoryController,
                    builder: (context, state, _) {
                      if (fetchTicketHistoryController.isLoading) {
                        return const Center(child: CustomLoading());
                      } else if (fetchTicketHistoryController.hasError) {
                        return Center(
                          child: RequestError(
                            message:
                                fetchTicketHistoryController.error.toString(),
                          ),
                        );
                      }
                      if (state.itemsTicketHistory != null &&
                          state.itemsTicketHistory!.isNotEmpty) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: fetchTicketHistoryController
                                      .state.itemsTicketHistory!.isNotEmpty
                                  ? true
                                  : false,
                              child: Padding(
                                padding: EdgeInsets.all(const Spacing(2).value),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() => viewHistory = !viewHistory);
                                  },
                                  child: Text(
                                    Tr.of(context).history,
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      color: context.colorScheme.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: viewHistory,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: const Spacing(3).value,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                Tr.of(context).historyValue,
                                                softWrap: true,
                                                style: context
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: AppColorsBase.grey6,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              DateFormat.toDateTime(
                                                DateTime.now(),
                                              ),
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: const Spacing(2.5).value,
                                              ),
                                              child: Text(
                                                Tr.of(context).amountSaved,
                                                softWrap: true,
                                                style: context
                                                    .textTheme.bodySmall
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
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TicketHistoryList(
                                    controller: fetchTicketHistoryController,
                                    authController: authController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
