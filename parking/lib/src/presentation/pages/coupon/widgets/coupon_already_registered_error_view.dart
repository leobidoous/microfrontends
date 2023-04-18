import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../domain/failures/coupon/coupon_failure.dart';
import '../../../routes/parking_routes.dart';

class CouponAlreadyRegisteredErrorView extends StatelessWidget {
  const CouponAlreadyRegisteredErrorView({
    super.key,
    required this.error,
    required this.parkingRoleUrl,
  });

  final ICouponFailure error;
  final String parkingRoleUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.zero(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacing.sm.vertical,
              CustomScrollContent(
                child: SvgPicture.asset(
                  'assets/images/parking/coupon_already_registred.svg',
                ),
              ),
              Spacing.sm.vertical,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Cupom já registrado!',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge,
                  ),
                  Spacing.md.vertical,
                  Text(
                    '''Este cupom já foi registrado anteriormente. Tente registrar outro.''',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: context.textTheme.fontWeightLight,
                    ),
                  ),
                ],
              ),
              Spacing.sm.vertical,
              CustomButton.text(
                text: 'Registrar novo cupom',
                onPressed: () => Nav.to.pop(response: error),
              ),
              Spacing.sm.vertical,
              Center(
                child: TextLink(
                  onTap: () {
                    Nav.to.pushNamed(
                      ParkingRoutes.regulation,
                      arguments: parkingRoleUrl,
                    );
                  },
                  text: Tr.of(context).seeRegulation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
