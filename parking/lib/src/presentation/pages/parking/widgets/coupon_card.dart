import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../controllers/parking/parking_coupon_controller.dart';
import '../../../controllers/parking/parking_ticket_controller.dart';
import '../../../routes/coupon_routes.dart';
import '../../../routes/parking_routes.dart';
import '../../../routes/ticket_routes.dart';
import '../../../widgets/coupon_registration_status.dart';
import 'shopping_location.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.couponController,
    required this.ticketController,
    required this.onRefresh,
    required this.shopping,
  });

  final ParkingCouponController couponController;
  final ParkingTicketController ticketController;
  final VoidCallback onRefresh;
  final ShoppingEntity shopping;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ValueListenableBuilder<CouponEntity>(
        valueListenable: couponController,
        builder: (_, coupon, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImage(
                url: shopping.logoImage,
                height: const Spacing(15).value.responsiveHeight,
              ),
              Spacing.sm.vertical,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextLink(
                    isEnabled: !(couponController.isLoading ||
                        couponController.hasError),
                    text: Tr.of(context).seeRegulation,
                    onTap: () {
                      Nav.to.pushNamed(
                        ParkingRoutes.regulation.relativePath,
                        arguments: couponController.parkingRoleUrl,
                      );
                    },
                  ),
                ),
              ),
              Spacing.sm.vertical,
              MallLocation(
                shopping: shopping,
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                  vertical: const Spacing(1).value,
                ),
              ),
              Spacing.sm.vertical,
              if (couponController.hasError)
                RequestError(
                  message: couponController.error.toString(),
                  onPressed: onRefresh,
                  padding: EdgeInsets.all(const Spacing(2).value),
                  maxHeight: const Spacing(50).value.responsiveHeight,
                ),
              if (!couponController.hasError)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(2).value,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        Tr.of(context).addCouponsLabel,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: context.textTheme.fontWeightBold,
                        ),
                      ),
                      Spacing.sm.vertical,
                      Text(
                        Tr.of(context).registeredCoupons,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.sm.vertical,
                      if (couponController.isLoading)
                        CustomShimmer(height: const Spacing(1.5).value),
                      if (!couponController.isLoading)
                        CouponRegistrationStatus(
                          max: coupon.campaignValue,
                          actual: coupon.amount,
                        ),
                      Spacing.sm.vertical,
                      Row(
                        mainAxisAlignment:
                            coupon.qtdCoupon == 0 && !couponController.isLoading
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceBetween,
                        children: [
                          if (couponController.isLoading)
                            CustomShimmer(
                              height: const Spacing(1.5).value,
                              width: const Spacing(8).value,
                            ),
                          if (!couponController.isLoading)
                            Text(
                              Tr.of(context).validCoupons(coupon.qtdCoupon),
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: (coupon.qtdCoupon > 0)
                                    ? AppColorsBase.greyText01
                                    : context.colorScheme.primary,
                              ),
                            ),
                          if (coupon.qtdCoupon > 0)
                            TextLink(
                              isEnabled: !(couponController.isLoading ||
                                  couponController.hasError),
                              text: Tr.of(context).seeCoupons,
                              onTap: () {
                                Nav.to.pushNamed(
                                  CouponRoutes.couponsList,
                                  arguments: coupon.canGetFreeParking,
                                );
                              },
                            ),
                        ],
                      ),
                      Spacing.sm.vertical,
                      if (couponController.isLoading)
                        CustomShimmer(height: AppThemeBase.buttonHeightMD),
                      if (!couponController.isLoading)
                        _couponCTA(
                          context,
                          canGetFreeParking: coupon.canGetFreeParking,
                          hasUsedVoucher: coupon.hasUsedVoucher,
                        ),
                      Spacing.sm.vertical,
                      Text(
                        Tr.of(context).anotationCoupons,
                        style: context.textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.sm.vertical,
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _couponCTA(
    BuildContext context, {
    required bool canGetFreeParking,
    required bool hasUsedVoucher,
  }) {
    return ValueListenableBuilder<TicketEntity>(
      valueListenable: ticketController,
      builder: (context, ticket, child) {
        if (!hasUsedVoucher && !canGetFreeParking) {
          return CustomButton.text(
            text: Tr.of(context).addCoupon,
            onPressed: () async => await Nav.to
                .pushNamed(
              CouponRoutes.root.relativePath,
            )
                .then((value) {
              onRefresh();
            }),
          );
        } else if (canGetFreeParking && !hasUsedVoucher) {
          return CustomButton.text(
            text: Tr.of(context).validateParking,
            type: ButtonType.tertiary,
            onPressed: () {
              if (ticket.ticket == null && ticket.plate == null) {
                Nav.to.pushNamed(ParkingRoutes.enterTicketNumber);
                return;
              }
              if (ticketController.state.status.code == 2) {
                Nav.to.pushNamed(
                  TicketRoutes.ticketTracking.relativePath,
                  arguments: ticket.ticket ?? ticket.plate,
                );
              } else {
                Nav.to.pushNamed(TicketRoutes.root);
              }
            },
          );
        } else {
          return CustomButton.text(
            text: Tr.of(context).validateParking,
            type: ButtonType.tertiary,
            isEnabled: false,
          );
        }
      },
    );
  }
}
