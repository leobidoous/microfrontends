import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../controllers/parking/parking_coupon_controller.dart';
import '../../routes/ticket_window_routes.dart';
import '../../widgets/coupon_registration_status.dart';

class CouponSubmissionResultPage extends StatefulWidget {
  const CouponSubmissionResultPage({super.key});

  @override
  State<CouponSubmissionResultPage> createState() =>
      _CouponSubmissionResultPageState();
}

class _CouponSubmissionResultPageState
    extends State<CouponSubmissionResultPage> {
  final couponController = DM.i.get<ParkingCouponController>();
  final shopping = DM.i.get<ShoppingModel>();

  @override
  void initState() {
    super.initState();
    couponController.fetchCoupon(idShopping: shopping.id.toString());
  }

  Future<void> _showWarning() async {
    await GenDialog.show(
      context,
      GenAlert.validateAfterConfirm(
        context,
        btnCancelLabel: 'Cancelar',
        btnConfirmLabel: 'Sair',
        onConfirm: () => Nav.to.pop(response: true),
      ),
      showClose: true,
    ).then((value) {
      if (value == true) {
        Nav.to.popUntil(
          ModalRoute.withName(TicketWindowRoutes.root.completePath),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: GenAppBar.zero(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(const Spacing(2).value),
            child: ValueListenableBuilder<CouponEntity>(
              valueListenable: couponController,
              builder: (context, state, child) {
                if (couponController.isLoading) {
                  return const Center(child: GenLoading());
                } else if (couponController.hasError) {
                  return Center(
                    child: RequestError(
                      message: couponController.error.toString(),
                      onPressed: () {
                        couponController.fetchCoupon(
                          idShopping: shopping.id.toString(),
                        );
                      },
                      padding: EdgeInsets.zero,
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: _submissionResult(state)),
                    Spacing.sm.vertical,
                    if (!state.canGetFreeParking) ...[
                      Spacing.sm.vertical,
                      GenButton.text(
                        onPressed: () {
                          // Nav.to.pushNamed(
                          //   SharedRoutes.scanBardCode,
                          //   arguments: (code) {
                          //     Nav.to.pushReplacementNamed(
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
                        text: 'Pagar',
                      ),
                    ],
                    if (state.canGetFreeParking) ...[
                      Spacing.sm.vertical,
                      GenButton.text(
                        onPressed: () {
                          Nav.to.pushNamed(
                            TicketWindowRoutes
                                .scanTicketOrEnterPlate.relativePath,
                          );
                        },
                        text: 'Escanear tíquete',
                      ),
                    ],
                    if (!state.canGetFreeParking) ...[
                      Spacing.sm.vertical,
                      GenButton.text(
                        onPressed: () {
                          Nav.to.popUntil(
                            ModalRoute.withName(
                              TicketWindowRoutes.takePhoto.completePath,
                            ),
                          );
                        },
                        text: 'Enviar mais cupons',
                      ),
                    ],
                    Spacing.sm.vertical,
                    GenButton.text(
                      text: 'Validar depois',
                      onPressed: _showWarning,
                      type: ButtonType.background,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _submissionResult(CouponEntity coupon) {
    return GenRefreshIndicator(
      onRefresh: () async {
        couponController.fetchCoupon(
          idShopping: shopping.id.toString(),
        );
      },
      child: LayoutBuilder(
        builder: (context, constrains) {
          return GenScrollContent(
            child: SizedBox(
              height: constrains.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      if (couponController.state.canGetFreeParking)
                        TypewriterAnimatedText(
                          '''Você atingiu o valor para ganhar o estacionamento gratuito!''',
                          textStyle: context.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                          speed: const Duration(
                            milliseconds: 25,
                          ),
                        ),
                      if (!couponController.state.canGetFreeParking)
                        TypewriterAnimatedText(
                          '''Faltam ${NumberFormat.toCurrency((coupon.campaignValue - coupon.amount) / 100)} para você ganhar o estacionamento gratuito.''',
                          textStyle: context.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                          speed: const Duration(
                            milliseconds: 25,
                          ),
                        ),
                    ],
                  ),
                  Spacing.lg.vertical,
                  Text(
                    Tr.of(context).registeredCoupons,
                    textAlign: TextAlign.center,
                  ),
                  Spacing.sm.vertical,
                  CouponRegistrationStatus(
                    max: coupon.campaignValue,
                    actual: coupon.amount,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
