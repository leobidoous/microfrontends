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
import '../../../routes/ticket_routes.dart';
import '../../parking/widgets/ticket_card.dart';
import '../../ticket/widgets/ticket_card_details.dart';
import '../ticket_submit/ticket_submit_page.dart';
import '../widgets/ticket_shopping_info.dart';
import 'widgets/historys_info.dart';

part '../ticket_tracking/widgets/circular_indicator_timer.dart';

class TicketTrackingPage extends StatefulWidget {
  const TicketTrackingPage({super.key});

  @override
  State<TicketTrackingPage> createState() => _TicketTrackingPageState();
}

class _TicketTrackingPageState extends State<TicketTrackingPage> {
  final controller = DM.i.get<ParkingTicketController>();
  final authController = DM.i.get<SessionEntity>();
  final shopping = DM.i.get<ShoppingEntity>();

  @override
  void initState() {
    super.initState();
    controller.fecthInfoTicket(
      idShopping: shopping.id.toString(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
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
          } else if (controller.hasError &&
              state.plate == null &&
              state.ticket == null) {
            return ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: HistorysInfo(
                showMessageEmpty: true,
                onTapScanButton: onTapScanButton,
              ),
            );
          }
          return CustomScrollContent(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: controller.state.plate != null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: const Spacing(2).value,
                    ),
                    child: _VehicleTileWidget(
                      plate: state.plate ?? '',
                      brand: state.vehicle?.brand,
                      model: state.vehicle?.model,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: const Spacing(2).value),
                  child: _CircularIndicatorTimer(entity: state),
                ),
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
                const HistorysInfo(),
                Spacing.xxxl.vertical,
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

  bool showPaymentBottom() {
    final cod = controller.state.status.code;
    return (cod == 1 || cod == 3);
  }

  void onTapScanButton() async {
    await Nav.to.pushNamed(
      ParkingRoutes.scanTicket,
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
    ).then(
      (_) => controller.fecthInfoTicket(
        idShopping: shopping.id.toString(),
      ),
    );
  }
}

class _VehicleTileWidget extends StatelessWidget {
  const _VehicleTileWidget({
    required this.plate,
    this.brand,
    this.model,
  });

  final String? brand;
  final String? model;
  final String plate;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemeBase.borderRadiusMD,
      color: context.colorScheme.background,
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(const Spacing(2.5).value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CoreIcons.car,
              color: context.colorScheme.primary,
              size: 24.0,
            ),
            Expanded(
              child: Wrap(
                spacing: const Spacing(1).value,
                children: [
                  Visibility(
                    visible: (brand != null),
                    child: Padding(
                      padding: EdgeInsets.only(left: const Spacing(2.5).value),
                      child: Text(
                        brand ?? '',
                        maxLines: 2,
                        softWrap: true,
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColorsBase.primary10,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: const Spacing(2).value),
                    child: Text(
                      '${Tr.of(context).plate} $plate',
                      maxLines: 1,
                      softWrap: true,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColorsBase.greyText02,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (model != null),
                    child: Padding(
                      padding: EdgeInsets.only(left: const Spacing(2).value),
                      child: Text(
                        model ?? '',
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColorsBase.greyText02,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
