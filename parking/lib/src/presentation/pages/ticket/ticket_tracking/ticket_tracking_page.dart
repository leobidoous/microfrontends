import 'dart:async';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../../parking.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../domain/enums/ticket_status_enum.dart';
import '../../../controllers/parking/parking_ticket_controller.dart';
import '../../../controllers/ticket/tracking/ticket_count_down_controller.dart';
import '../../../controllers/ticket/tracking/ticket_history_controller.dart';
import '../../../routes/ticket_routes.dart';
import '../../ticket/widgets/ticket_card_details.dart';
import '../ticket_submit/ticket_submit_page.dart';
import 'ticket_tracking_empty_page.dart';
import 'widgets/historys_info.dart';

part '../ticket_tracking/widgets/circular_indicator_timer.dart';

class TicketTrackingPage extends StatefulWidget {
  const TicketTrackingPage({super.key});

  @override
  State<TicketTrackingPage> createState() => _TicketTrackingPageState();
}

class _TicketTrackingPageState extends State<TicketTrackingPage> {
  final ticketHistoryController = DM.i.get<TicketHistoryController>();
  final controller = DM.i.get<ParkingTicketController>();
  final authController = DM.i.get<SessionEntity>();

  ///TODO: pendencia do [BIDÓ]
  // final shopping = DM.i.get<ShoppingModel>();

  @override
  void initState() {
    super.initState();
    controller.fecthInfoTicket(
      idShopping: '3', //shopping.id.toString(),
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
      appBar: CustomAppBar(
        title: Tr.of(context).ticketTitle,
        onBackTap: Nav.to.pop,
        actions: [
          AppBarButton(
            child: Icon(
              CoreIcons.contactUs,
              color: context.colorScheme.onBackground,
              size: const Spacing(3).value,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      body: ValueListenableBuilder<TicketEntity>(
        valueListenable: controller,
        builder: (context, state, _) {
          if (controller.isLoading) {
            return const Center(child: CustomLoading());
          } else if (controller.hasError ||
              (state.plate == null && state.ticket == null)) {
            return const TicketTrackingEmptyPage();
          }
          return CustomScrollContent(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: AppThemeBase.borderRadiusMD,
                      ),
                      child: ColoredBox(
                        color: context.colorScheme.background,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: const Spacing(3).value,
                                top: const Spacing(3).value,
                                bottom: const Spacing(3).value,
                                right: const Spacing(3).value / 2,
                              ),
                              child: const Icon(
                                CoreIcons.car,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              height: const Spacing(5).value,
                              child: VerticalDivider(
                                width: 1,
                                thickness: 2,
                                color: AppColorsBase.greyText02,
                              ),
                            ),
                            Text(
                              'Mercedes',
                              style: context.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Placa htj-8923',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: AppColorsBase.greyText02,
                              ),
                            ),
                            Text(
                              'CLA - 250',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: AppColorsBase.greyText02,
                              ),
                            ),
                            SizedBox(width: const Spacing(2).value),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacing.sm.vertical,
                _CircularIndicatorTimer(entity: state),
                textCircularIndicator(state),
                Spacing.sm.vertical,

                ///TODO: DESCOMENTAR QUANDO IMPLEMENTAR
                ///INJEÇÃO DO [ShoppingEntity]
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: const Spacing(2).value,
                //   ),
                //   child: TicketShoppingInfo(shopping: shopping),
                // ),
                Spacing.sm.vertical,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(2).value,
                  ),
                  child: TicketCardDetails(ticket: state),
                ),
                Spacing.sm.vertical,
                const HistorysInfo(),
                // ValueListenableBuilder(
                //   valueListenable: ticketHistoryController,
                //   builder: (_, historys, __) {
                //     if (ticketHistoryController.isLoading) {
                //       return const LimitedBox();
                //     } else if (historys.isNotEmpty) {
                //       return Column(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //               horizontal: const Spacing(3).value,
                //             ),
                //             child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment:
                // MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Column(
                //                   crossAxisAlignment:
                // CrossAxisAlignment.start,
                //                   children: [
                //                     Padding(
                //                       padding: EdgeInsets.only(
                //                         top: const Spacing(2.5).value,
                //                       ),
                //                       child: Text(
                //                         Tr.of(context).historyValue,
                //                         softWrap: true,
                //                         style: context.textTheme.bodySmall
                //                             ?.copyWith(
                //                           color: AppColorsBase.grey6,
                //                         ),
                //                       ),
                //                     ),
                //                     Text(
                //                       historys.first.data ?? '??/??/????',
                //                       style: context.textTheme.titleMedium
                //                           ?.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.end,
                //                   children: [
                //                     Padding(
                //                       padding: EdgeInsets.only(
                //                         top: const Spacing(2.5).value,
                //                       ),
                //                       child: Text(
                //                         Tr.of(context).amountSaved,
                //                         softWrap: true,
                //                         style: context.textTheme.bodySmall
                //                             ?.copyWith(
                //                           color: AppColorsBase.grey6,
                //                         ),
                //                       ),
                //                     ),
                //                     Text(
                //                       'R\$ ${NumberFormat.toCurrency(
                //                         historys.first.valorEconomizado,
                //                         symbol: '',
                //                       )}',
                //                       style: context.textTheme.titleMedium
                //                           ?.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //               vertical: const Spacing(1).value,
                //             ),
                //             child: TicketHistoryList(
                //               historyController: ticketHistoryController,
                //               authController: authController,
                //             ),
                //           ),
                //         ],
                //       );
                //     }
                //     return const LimitedBox();
                //   },
                // ),

                SizedBox(
                  height: Spacing.xxxl.height,
                ),
                showPaymentBottom()
                    ? SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: const Spacing(2).value,
                          ),
                          child: CustomButton.text(
                            text: Tr.of(context).continueButton,
                            type: ButtonType.tertiary,
                            onPressed: () {
                              Nav.to.pushNamed(
                                TicketRoutes.root,
                                arguments: TicketSubmitPageArgs(
                                  ticketOrPlate: controller.state.ticket ?? '',
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
                  Tr.of(context).exitLimited,
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
                  '${Tr.of(context).estimatedValue}: ',
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
                  Tr.of(context).exitLimited,
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
                  Tr.of(context).outputLimitExceeded,
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
                  Tr.of(context).exitLimited,
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
