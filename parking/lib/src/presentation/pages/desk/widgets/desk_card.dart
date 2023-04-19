import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_assets.dart';
import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../../domain/enums/desk_cart_status_enum.dart';
import '../../../controllers/gen_desk/gen_desk_controller.dart';
import '../../../controllers/parking/parking_coupon_controller.dart';
import '../../../routes/coupon_routes.dart';
import '../../../routes/ticket_window_routes.dart';
import '../../../widgets/coupon_registration_status.dart';

class DeskCard extends StatefulWidget {
  const DeskCard({
    super.key,
    required this.onReturn,
    required this.deskController,
    required this.couponController,
  });

  final GenDeskController deskController;
  final ParkingCouponController couponController;
  final VoidCallback onReturn;

  @override
  State<DeskCard> createState() => _DeskCardState();
}

class _DeskCardState extends State<DeskCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CouponEntity>(
      valueListenable: widget.couponController,
      builder: (context, coupon, child) {
        return ValueListenableBuilder<DeskCardStatus>(
          valueListenable: widget.deskController,
          builder: (context, status, child) {
            return CustomCard(
              border: Border.all(
                color: context.colorScheme.primary,
                width: context.textTheme.lineHeightMedium,
              ),
              isSelected: !widget.couponController.isLoading &&
                  status != DeskCardStatus.initial,
              padding: EdgeInsets.all(const Spacing(2).value),
              child: LocalTheme.dark(
                builder: (darkContext) {
                  final textStyle = widget.couponController.isLoading
                      ? context.textTheme.bodyMedium
                      : status == DeskCardStatus.initial
                          ? context.textTheme.bodyMedium
                          : darkContext.textTheme.bodyMedium;
                  return _deskCard(textStyle);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _deskCard(TextStyle? textStyle) {
    final isLoading = widget.couponController.isLoading;
    final hasError = widget.couponController.hasError;
    final coupon = widget.couponController.state;
    final status = widget.deskController.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              CustomAssets.genDeskCard,
              width: const Spacing(5).value.responsiveWidth,
              height: const Spacing(5).value.responsiveHeight,
              color: textStyle?.color,
            ),
            Expanded(
              child: Text(
                Tr.of(context).deskTitle,
                textAlign: TextAlign.center,
                style: textStyle?.copyWith(
                  fontWeight: context.textTheme.fontWeightMedium,
                  fontSize: context.textTheme.titleLarge?.fontSize,
                ),
              ),
            ),
            const Spacing(5).horizontal,
          ],
        ),
        Spacing.md.vertical,
        if (isLoading)
          LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: [
                  CustomShimmer(
                    height: const Spacing(1.5).value,
                    width: constrains.maxWidth * .85,
                  ),
                  Spacing.xs.vertical,
                  CustomShimmer(
                    height: const Spacing(1.5).value,
                    width: constrains.maxWidth * .9,
                  ),
                  Spacing.xs.vertical,
                  CustomShimmer(
                    height: const Spacing(1.5).value,
                    width: constrains.maxWidth * .7,
                  ),
                ],
              );
            },
          ),
        if (!isLoading)
          Text(
            status == DeskCardStatus.initial
                ? Tr.of(context).deskDoubtsInfo
                : Tr.of(context).deskDoubtsInfoPending,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        Spacing.lg.vertical,
        Text(
          Tr.of(context).totalAmountRegistered,
          textAlign: TextAlign.center,
          style: textStyle?.copyWith(
            fontWeight: context.textTheme.fontWeightBold,
          ),
        ),
        Spacing.sm.vertical,
        if (isLoading) CustomShimmer(height: const Spacing(1.5).value),
        if (!isLoading)
          CouponRegistrationStatus(
            max: coupon.campaignValue.toDouble(),
            actual: coupon.amount.toDouble(),
            textStyle: textStyle,
          ),
        if (status == DeskCardStatus.initial) ...[
          Spacing.sm.vertical,
          Row(
            children: [
              if (isLoading)
                Expanded(
                  child: CustomShimmer(height: const Spacing(1.5).value),
                ),
              if (!isLoading)
                Expanded(
                  child: Text(
                    Tr.of(context).validCoupons(coupon.qtdCoupon),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              Spacing.sm.horizontal,
              if (!isLoading)
                TextLink(
                  text: Tr.of(context).seeCoupons,
                  isEnabled: !(isLoading || widget.couponController.hasError),
                  onTap: () {
                    Nav.to.pushNamed(
                      CouponRoutes.couponsList.relativePath,
                      arguments: coupon.canGetFreeParking,
                    );
                  },
                ),
            ],
          ),
        ],
        if (isLoading) ...[
          Spacing.lg.vertical,
          CustomShimmer(height: AppThemeBase.buttonHeightMD),
        ],
        if (!isLoading && !hasError) ...[
          if (status != DeskCardStatus.initial) ...[
            Spacing.lg.vertical,
            LocalTheme.light(
              builder: (context) {
                return CustomButton.text(
                  onPressed: () async {
                    await Nav.to
                        .pushNamed(TicketWindowRoutes.root.prevPath())
                        .then((value) => widget.onReturn());
                  },
                  text: status == DeskCardStatus.pending
                      ? Tr.of(context).startRelease
                      : Tr.of(context).continueRelease,
                  type: ButtonType.secondary,
                );
              },
            ),
          ],
        ],
        if (hasError)
          RequestError(
            message: widget.couponController.error.toString(),
            onPressed: widget.onReturn,
            btnType: ButtonType.tertiary,
            padding: EdgeInsets.all(const Spacing(2).value),
            maxHeight: const Spacing(50).value.responsiveHeight,
          ),
      ],
    );
  }
}
