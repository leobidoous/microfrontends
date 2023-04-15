import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../parking.dart';
import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../routes/coupon_routes.dart';
import '../../routes/ticket_routes.dart';
import '../ticket/ticket_submit_page.dart';

class ParkingAmountInfoPage extends StatelessWidget {
  const ParkingAmountInfoPage({
    super.key,
    required this.ticketOrPlate,
    required this.coupon,
  });

  final String ticketOrPlate;
  final CouponEntity coupon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(title: 'Estacionamento'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacing.md.vertical,
              SvgPicture.asset(
                'assets/images/parking/remaining_parking_amount_info.svg',
              ),
              Spacing.md.vertical,
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Faltam ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    fontSize: AppFontSize.bodyLarge.value,
                    color: AppColorsBase.grey9,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '''${NumberFormat.toCurrency((coupon.campaignValue - coupon.amount) / 100)} ''',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: context.textTheme.fontWeightBold,
                      ),
                    ),
                    const TextSpan(
                      text:
                          '''reais para você \nganhar o estacionamento gratuito.''',
                    )
                  ],
                ),
              ),
              Spacing.xxxl.vertical,
              GenButton.text(
                onPressed: () {
                  Nav.to.pushNamed(
                    TicketRoutes.root,
                    arguments: TicketSubmitPageArgs(
                      ticketOrPlate: ticketOrPlate,
                      onPop: () {
                        Nav.to.popUntil(
                          ModalRoute.withName(ParkingRoutes.root.completePath),
                        );
                      },
                    ),
                  );
                },
                text: 'Pagar',
                type: ButtonType.tertiary,
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: () {
                  Nav.to.pushReplacementNamed(
                    CouponRoutes.couponsList,
                    arguments: false,
                  );
                },
                text: 'Ver cupons fiscais',
                type: ButtonType.background,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
