import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_assets.dart';
import '../../../../../l10n/translations.dart';
import '../../../../../parking.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../controllers/parking/parking_controller.dart';
import '../../../routes/ticket_routes.dart';
import '../ticket_submit/ticket_submit_page.dart';
import 'widgets/historys_info.dart';

class TicketTrackingEmptyPage extends StatefulWidget {
  const TicketTrackingEmptyPage({super.key});

  @override
  State<TicketTrackingEmptyPage> createState() =>
      _TicketTrackingEmptyPageState();
}

class _TicketTrackingEmptyPageState extends State<TicketTrackingEmptyPage> {
  final authController = DM.i.get<SessionEntity>();
  final controller = DM.i.get<ParkingController>();

  // final shopping = DM.i.get<ShoppingModel>();

  @override
  void initState() {
    super.initState();
    controller.ticketController.fecthInfoTicket(
      idShopping: '1', //shopping.id.toString(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
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
                      text: Tr.of(context).scanTicketButton,
                      onPressed: () {
                        Nav.to.pushNamed(
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
                        );
                      },
                    ),
                  ),
                  const HistorysInfo(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
