import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../parking.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../controllers/gen_desk/fetch_faq_controller.dart';
import '../../controllers/gen_desk/gen_desk_controller.dart';
import '../../controllers/parking/parking_coupon_controller.dart';
import '../../controllers/parking/parking_controller.dart';
import '../../controllers/parking/parking_ticket_controller.dart';
import '../../routes/ticket_routes.dart';
import '../../widgets/talk_with_us.dart';
import '../ticket/ticket_submit_page.dart';
import 'widgets/desk_card.dart';
import 'widgets/faq_list.dart';

class GenDeskPage extends StatefulWidget {
  const GenDeskPage({super.key});

  @override
  State<GenDeskPage> createState() => _GenDeskPageState();
}

class _GenDeskPageState extends State<GenDeskPage> {
  final shopping = DM.i.get<ShoppingModel>();
  final faqController = DM.i.get<FetchFAQController>();
  final deskController = DM.i.get<GenDeskController>();
  final parkingController = DM.i.get<ParkingController>();
  final authController = DM.i.get<GlobalAuthController>();
  late final ParkingTicketController ticketController;
  late final ParkingCouponController couponController;

  @override
  void initState() {
    super.initState();
    ticketController = parkingController.ticketController;
    couponController = parkingController.couponController;
    deskController.fetchParkingReleaseStatus();
  }

  void getCoupon() {
    parkingController.couponController.fetchCoupon(
      idShopping: shopping.id.toString(),
    );
  }

  void getTicket() async {
    parkingController.ticketController.fecthInfoTicket(
      idShopping: shopping.id.toString(),
    );
  }

  void _onScanPayOrValidateTicket() {
    final ticket = ticketController.state;
    final coupon = couponController.state;
    if (authController.emailVerified.value) {
      if (ticket.status.code == 2) {
        Nav.to.pushNamed(TicketRoutes.ticketTracking);
        return;
      }
      if (ticket.ticket == null && ticket.plate == null) {
        Nav.to.pushNamed(
          SharedRoutes.scanBardCode,
          arguments: (code) {
            Nav.to.pushReplacementNamed(
              TicketRoutes.root,
              arguments: TicketSubmitPageArgs(
                ticketOrPlate: code,
                onPop: () {
                  Nav.to.popUntil(
                    ModalRoute.withName(ParkingRoutes.root.completePath),
                  );
                },
              ),
            );
          },
        );
        return;
      }
      if (ticket.discount.percentOfDiscount != 1) {
        Nav.to.pushNamed(
          ParkingRoutes.parkingAmountInfo,
          arguments: [
            ticket.plate ?? ticket.ticket,
            coupon,
          ],
        );
        return;
      } else {
        Nav.to.pushNamed(
          TicketRoutes.root,
          arguments: TicketSubmitPageArgs(
            ticketOrPlate: ticket.plate ?? ticket.ticket ?? '',
            onPop: () {
              Nav.to.popUntil(
                ModalRoute.withName(ParkingRoutes.root.completePath),
              );
            },
          ),
        );
      }
    } else {
      GenDialog.show(
        context,
        GenAlert.emailVerified(context),
        showClose: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: context.tr.deskTitle,
        actions: [
          ValueListenableBuilder<TicketEntity>(
            valueListenable: ticketController,
            builder: (context, ticket, child) {
              return AppBarButton(
                isEnabled: !ticketController.isLoading,
                onTap: _onScanPayOrValidateTicket,
                child: Icon(
                  GenIcons.barCode,
                  color: context.colorScheme.primary,
                  size: const Spacing(3).value,
                ),
              );
            },
          ),
        ],
      ),
      body: GenRefreshIndicator(
        onRefresh: () async {
          faqController.fetchFAQs();
          deskController.fetchParkingReleaseStatus();
          getCoupon();
          getTicket();
        },
        child: GenScrollContent(
          padding: EdgeInsets.symmetric(vertical: const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: GenImage(
                  url: shopping.logoImage,
                  radius: context.theme.borderRadiusMD,
                  height: const Spacing(15).value.responsiveHeight,
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: couponController,
                    builder: (context, coupon, child) {
                      return TextLink(
                        isEnabled: !(couponController.isLoading ||
                            couponController.hasError),
                        text: context.tr.seeRegulation,
                        onTap: () {
                          Nav.to.pushNamed(
                            ParkingRoutes.regulation.completePath,
                            arguments: couponController.parkingRoleUrl,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: DeskCard(
                  deskController: deskController,
                  couponController: couponController,
                  onReturn: getCoupon,
                ),
              ),
              Spacing.md.vertical,
              const TalkWithUs(),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: Text(
                  context.tr.mainDoubts,
                  style: context.textTheme.titleLarge,
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: GenCard(
                  padding: EdgeInsets.all(const Spacing(2).value),
                  border: Border.all(
                    color: AppColorsBase.neutrla3,
                    width: context.textTheme.lineHeightMedium,
                  ),
                  child: const FAQList(),
                ),
              ),
              SafeArea(child: const Spacing(0).vertical),
            ],
          ),
        ),
      ),
    );
  }
}
