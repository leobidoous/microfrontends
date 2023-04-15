import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../controllers/parking/parking_controller.dart';
import '../../routes/ticket_routes.dart';
import '../../widgets/talk_with_us.dart';
import '../ticket/ticket_submit_page.dart';
import 'widgets/coupon_card.dart';
import 'widgets/no_ticket_found_card.dart';
import 'widgets/ticket_card.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({super.key});

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  final session = DM.i.get<SessionEntity>();
  final controller = DM.i.get<ParkingController>();
  final shopping = DM.i.get<ShoppingModel>();

  @override
  void initState() {
    super.initState();
    getTicket();
    getCoupon();
  }

  void getCoupon() {
    controller.couponController.fetchCoupon(
      idShopping: shopping.id.toString(),
    );
  }

  void getTicket() async {
    controller.ticketController.fecthInfoTicket(
      idShopping: shopping.id.toString(),
    );
  }

  void _onScanPayOrValidateTicket() {
    final ticket = controller.ticketController.state;
    final coupon = controller.couponController.state;
    if (session.customer.emailVerifiedAt.isNotEmpty) {
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
                  getTicket();
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
              getTicket();
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
        title: context.tr.parking,
        onBackTap: Nav.to.pop,
        actions: [
          ValueListenableBuilder<TicketEntity>(
            valueListenable: controller.ticketController,
            builder: (context, ticket, child) {
              return AppBarButton(
                onTap: _onScanPayOrValidateTicket,
                isEnabled: !controller.ticketController.isLoading,
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
          getCoupon();
          getTicket();
        },
        child: GenScrollContent(
          padding: EdgeInsets.only(top: const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: _HeaderDashboard(),
              ),
              Spacing.lg.vertical,
              _LinkCard(),
              Spacing.lg.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: Text(
                  context.tr.campaignHeader,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightBold,
                  ),
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: CouponCardNew(
                  ticketController: controller.ticketController,
                  couponController: controller.couponController,
                  onRefresh: getCoupon,
                  shopping: shopping,
                ),
              ),
              Spacing.lg.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: Text(
                  context.tr.ticketTitle,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightBold,
                  ),
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: _ticketCard,
              ),
              Spacing.lg.vertical,
              const TalkWithUs(isSafeArea: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _ticketCard {
    return GenCard(
      child: ValueListenableBuilder<TicketEntity>(
        valueListenable: controller.ticketController,
        builder: (_, state, child) {
          if (controller.ticketController.isLoading) {
            return SizedBox(
              height: const Spacing(50).value.responsiveHeight,
              child: const Center(child: GenLoading()),
            );
          }
          if (controller.ticketController.error.runtimeType ==
              NoTicketFoundError) {
            return Padding(
              padding: EdgeInsets.all(const Spacing(1.5).value),
              child: ValueListenableBuilder<CouponEntity>(
                valueListenable: controller.couponController,
                builder: (_, coupon, child) {
                  final isEnabled =
                      (shopping.id == 11 && coupon.canGetFreeParking) ||
                          (shopping.id != 11 &&
                              (coupon.canGetFreeParking ||
                                  (coupon.customerCreation[
                                          'can_get_half_parking'] ??
                                      false)));
                  return NoTicketFoundCard(
                    isEnabled: isEnabled,
                    onRefresh: () {
                      getCoupon();
                      getTicket();
                    },
                  );
                },
              ),
            );
          }
          return TicketCard(
            ticket: state,
            shopping: shopping,
            controller: controller.couponController,
            onPayOrValidateTicket: _onScanPayOrValidateTicket,
          );
        },
      ),
    );
  }
}
