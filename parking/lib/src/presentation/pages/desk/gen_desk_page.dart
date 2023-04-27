import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../controllers/gen_desk/fetch_faq_controller.dart';
import '../../controllers/gen_desk/gen_desk_controller.dart';
import '../../controllers/parking/parking_controller.dart';
import '../../controllers/parking/parking_coupon_controller.dart';
import '../../controllers/parking/parking_ticket_controller.dart';
import '../../routes/parking_routes.dart';
import '../../widgets/talk_with_us.dart';
import 'widgets/desk_card.dart';
import 'widgets/faq_list.dart';

class GenDeskPage extends StatefulWidget {
  const GenDeskPage({super.key});

  @override
  State<GenDeskPage> createState() => _GenDeskPageState();
}

class _GenDeskPageState extends State<GenDeskPage> {
  final shopping = DM.i.get<ShoppingEntity>();
  final faqController = DM.i.get<FetchFAQController>();
  final deskController = DM.i.get<GenDeskController>();
  final parkingController = DM.i.get<ParkingController>();
  final session = DM.i.get<SessionEntity>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Tr.of(context).deskTitle),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          faqController.fetchFAQs();
          deskController.fetchParkingReleaseStatus();
          getCoupon();
          getTicket();
        },
        child: CustomScrollContent(
          padding: EdgeInsets.symmetric(vertical: const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: CustomImage(
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
                        text: Tr.of(context).seeRegulation,
                        onTap: () {
                          Nav.to.pushNamed(
                            ParkingRoutes.regulation,
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
                  Tr.of(context).mainDoubts,
                  style: context.textTheme.titleLarge,
                ),
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: CustomCard(
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
