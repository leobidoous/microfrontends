import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../routes/coupon_routes.dart';
import '../../routes/parking_routes.dart';
import '../../widgets/coupon_registration_status.dart';

class CouponSuccessfullyRegisteredPageArgs {
  CouponSuccessfullyRegisteredPageArgs({
    required this.coupon,
    required this.transaction,
  });

  final CouponEntity coupon;
  final TransactionEntity transaction;
}

class CouponSuccessfullyRegisteredPage extends StatefulWidget {
  final CouponSuccessfullyRegisteredPageArgs args;

  const CouponSuccessfullyRegisteredPage({super.key, required this.args});

  @override
  State<CouponSuccessfullyRegisteredPage> createState() =>
      _CouponSuccessfullyRegisteredPageState();
}

class _CouponSuccessfullyRegisteredPageState
    extends State<CouponSuccessfullyRegisteredPage> {
  late final CouponEntity coupon;
  late final TransactionEntity transaction;

  @override
  void initState() {
    super.initState();
    coupon = widget.args.coupon;
    transaction = widget.args.transaction;
  }

  @override
  Widget build(BuildContext context) {
    final freeParking = coupon.canGetFreeParking;
    double resting = 0;
    if (!freeParking) {
      resting = (coupon.campaignValue - coupon.amount) / 100;
    }
    return Scaffold(
      appBar: GenAppBar(
        automaticallyImplyLeading: false,
        showDivider: false,
        actions: [
          AppBarButton(
            onTap: Nav.to.pop,
            child: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cupom registrado com sucesso!',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              Spacing.xl.vertical,
              if (freeParking)
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/parking/free_ticket_success.svg',
                  ),
                ),
              if (!freeParking)
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/parking/coupon_registred_success.svg',
                  ),
                ),
              Spacing.xl.vertical,
              if (!freeParking)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: context.theme.borderRadiusSM,
                    color: AppColorsBase.success0,
                  ),
                  padding: EdgeInsets.all(const Spacing(2).value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColorsBase.success2,
                      ),
                      Spacing.sm.horizontal,
                      Text(
                        '''Valor de R\$ ${NumberFormat.toCurrency(transaction.totalCents / 100)} registrado''',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColorsBase.success2,
                          fontWeight: context.textTheme.fontWeightMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              Spacing.xxl.vertical,
              if (!freeParking) ...[
                Text(
                  '''Faltam R\$ ${NumberFormat.toCurrency(resting)} para você ganhar o estacionamento gratuito''',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ],
              if (freeParking) ...[
                Text(
                  '''Você atingiu o valor para ganhar o estacionamento gratuito!''',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
                Spacing.sm.vertical,
                CouponRegistrationStatus(
                  max: coupon.campaignValue,
                  actual: coupon.amount,
                ),
              ],
              Spacing.xxl.vertical,
              if (freeParking) ...[
                GenButton.text(
                  onPressed: () {
                    // Nav.to.pushReplacementNamed(
                    //   SharedRoutes.scanBardCode,
                    //   arguments: (code) {
                    //     Nav.to.pushNamed(
                    //       TicketRoutes.root,
                    //       arguments: TicketSubmitPageArgs(
                    //         ticketOrPlate: code,
                    //         onPop: () {
                    //           Nav.to.popUntil(
                    //             ModalRoute.withName(
                    //               ParkingRoutes.root.completePath,
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  type: ButtonType.tertiary,
                  text: 'Validar tíquete',
                ),
                Spacing.sm.vertical,
                GenButton.text(
                  onPressed: () {
                    Nav.to.pushReplacementNamed(ParkingRoutes.enterPlateNumber);
                  },
                  type: ButtonType.background,
                  text: 'Digite a placa',
                ),
                Spacing.sm.vertical,
              ],
              if (!freeParking) ...[
                GenButton.text(
                  onPressed: () {
                    Nav.to.pushReplacementNamed(CouponRoutes.root);
                  },
                  text: 'Registrar novo cupom',
                ),
                Spacing.sm.vertical,
              ],
              if (!freeParking)
                GenButton.text(
                  type: ButtonType.background,
                  text: 'Ver cupons fiscais',
                  onPressed: () {
                    Nav.to.pushReplacementNamed(
                      CouponRoutes.couponsList,
                      arguments: freeParking,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
