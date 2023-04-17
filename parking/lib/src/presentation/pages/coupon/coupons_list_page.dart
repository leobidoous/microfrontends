import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';
import '../../controllers/coupon/coupons_list_controller.dart';
import '../../routes/coupon_routes.dart';

class CouponsListPage extends StatefulWidget {
  const CouponsListPage({super.key, required this.freeParking});
  final bool freeParking;

  @override
  State<CouponsListPage> createState() => _CouponsListPageState();
}

class _CouponsListPageState extends State<CouponsListPage> {
  final controller = DM.i.get<CouponsListController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(title: 'Acompanhamento'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Text(
                'Veja todos seus cupons fiscais de hoje',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColorsBase.greyText02,
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<TransactionEntity>>(
                valueListenable: controller,
                builder: (context, state, child) {
                  if (controller.isLoading) {
                    return const Center(
                      child: GenLoading(),
                    );
                  } else if (controller.hasError) {
                    return Center(
                      child: RequestError(
                        message: controller.error.toString(),
                        onPressed: controller.fetchCoupons,
                        padding: EdgeInsets.all(const Spacing(2).value),
                      ),
                    );
                  } else if (state.isEmpty) {
                    return Center(
                      child: ListEmpty(
                        padding: EdgeInsets.all(const Spacing(2).value),
                        message:
                            '''Você ainda não tem cupons fiscais registrados.''',
                        asset: 'assets/images/parking/coupons_empty_list.svg',
                        onPressed: controller.fetchCoupons,
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GenRefreshIndicator(
                          onRefresh: () async {
                            controller.fetchCoupons();
                          },
                          child: ListView.separated(
                            itemCount: state.length,
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: const Spacing(2).value,
                            ),
                            separatorBuilder: (_, __) => Spacing.sm.vertical,
                            itemBuilder: (_, index) {
                              return _couponListItem(state[index]);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(const Spacing(2).value),
                        child: GenButton.text(
                          onPressed: () {
                            if (widget.freeParking) {
                              // Nav.to.pushReplacementNamed(
                              //   SharedRoutes.enterTicketNumber,
                              // );
                              return;
                            }
                            Nav.to.pushReplacementNamed(CouponRoutes.root);
                          },
                          type: widget.freeParking
                              ? ButtonType.tertiary
                              : ButtonType.primary,
                          text: widget.freeParking
                              ? 'Validar estacionamento'
                              : 'Adicionar cupons',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _couponListItem(TransactionEntity transaction) {
    return InkWell(
      onTap: () {
        Nav.to.pushNamed(CouponRoutes.couponDetails, arguments: transaction);
      },
      child: CustomPaint(
        painter: CouponBorderPainter(),
        isComplex: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: const Spacing(10).value,
            vertical: const Spacing(3).value,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '''Cupom nº ${AcquirerPaymentModel.fromEntity(transaction.acquirerPayment).nCoupon}''',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              Spacing.xs.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Valor total',
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColorsBase.greyText02,
                        fontWeight: context.textTheme.fontWeightLight,
                      ),
                    ),
                  ),
                  Spacing.xs.vertical,
                  Flexible(
                    child: Text(
                      NumberFormat.toCurrency(transaction.totalCents / 100),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColorsBase.grey9,
                        fontWeight: context.textTheme.fontWeightMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Spacing.xs.vertical,
              Text(
                DateFormat.toDateTime(
                  transaction.insertedAt,
                  pattern: 'dd/MM/yyyy - HH:mm:ss',
                ),
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium?.copyWith(
                  color: AppColorsBase.greyText02,
                  fontWeight: context.textTheme.fontWeightLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
