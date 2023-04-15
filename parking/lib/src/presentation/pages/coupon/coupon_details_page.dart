import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../routes/coupon_routes.dart';

class CouponDetailsPage extends StatefulWidget {
  final TransactionEntity transaction;
  const CouponDetailsPage({super.key, required this.transaction});

  @override
  State<CouponDetailsPage> createState() => _CouponDetailsPageState();
}

class _CouponDetailsPageState extends State<CouponDetailsPage> {
  // TODO: melhorar método ou passagem de parametro para obter o shopping
  final shopping = DM.i.get<ShoppingModel>();
  late final String sellerLabel;

  @override
  void initState() {
    super.initState();
    sellerLabel = widget.transaction.seller.displayName.isNotEmpty
        ? widget.transaction.seller.displayName
        : widget.transaction.seller.company.businessName.isNotEmpty
            ? widget.transaction.seller.company.businessName
            : widget.transaction.seller.company.tradeName.isNotEmpty
                ? widget.transaction.seller.company.tradeName
                : widget.transaction.seller.person.name.isNotEmpty
                    ? widget.transaction.seller.person.name
                    : widget.transaction.method.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: 'Cupom Fiscal',
        actions: [
          AppBarButton(
            child: Icon(
              GenIcons.messageCircle,
              color: context.colorScheme.onBackground,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GenScrollContent(
                padding: EdgeInsets.all(const Spacing(2).value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _shoppingLocation,
                    Divider(
                      height: const Spacing(4).value,
                      color: AppColorsBase.neutrla1,
                    ),
                    _title(
                      '''Cupom nº ${AcquirerPaymentModel.fromEntity(widget.transaction.acquirerPayment).nCoupon}''',
                    ),
                    Spacing.sm.vertical,
                    Text(
                      DateFormat.toDateTime(
                        widget.transaction.insertedAt,
                        pattern: 'dd/MM/yyyy - HH:mm:ss',
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColorsBase.greyText02,
                        fontWeight: context.textTheme.fontWeightLight,
                      ),
                    ),
                    Divider(
                      height: const Spacing(4).value,
                      color: AppColorsBase.neutrla1,
                    ),
                    _title('Compra'),
                    Spacing.sm.vertical,
                    labelValueRow(
                      'Qdt. Itens',
                      widget.transaction.order.items.length.toString(),
                    ),
                    Spacing.sm.vertical,
                    labelValueRow(
                      'Valor total',
                      NumberFormat.toCurrency(
                        widget.transaction.totalCents / 100,
                      ),
                    ),
                    Divider(
                      height: const Spacing(4).value,
                      color: AppColorsBase.neutrla1,
                    ),
                    _title('Loja participante'),
                    Spacing.sm.vertical,
                    labelValueRow('Nome / Razão Social', sellerLabel),
                    Spacing.sm.vertical,
                    labelValueRow(
                      'CPF / CNPJ',
                      FormValidators.invalidCNPJ(
                                widget.transaction.acquirerPayment.cnpj,
                              ) !=
                              null
                          ? widget.transaction.acquirerPayment.cnpj
                          : UtilBrasilFields.obterCnpj(
                              widget.transaction.acquirerPayment.cnpj,
                            ),
                    ),
                    Divider(
                      height: const Spacing(4).value,
                      color: AppColorsBase.neutrla1,
                    ),
                    _title('Chave de acesso'),
                    Spacing.sm.vertical,
                    Text(
                      AcquirerPaymentModel.fromEntity(
                        widget.transaction.acquirerPayment,
                      ).formatedKey,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColorsBase.greyText02,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacing.sm.vertical,
            Padding(
              padding: EdgeInsets.fromLTRB(
                const Spacing(2).value,
                0,
                const Spacing(2).value,
                const Spacing(2).value,
              ),
              child: GenButton.text(
                onPressed: () {
                  Nav.to.pop();
                  Nav.to.pushReplacementNamed(CouponRoutes.root);
                },
                text: 'Registrar novo cupom',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _shoppingLocation {
    return Row(
      children: [
        Icon(
          GenIcons.locationPinAlt,
          color: AppColorsBase.grey9,
        ),
        Spacing.xs.horizontal,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                shopping.name,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium,
              ),
              Spacing.xs.vertical,
              Text(
                shopping.address ?? '...',
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium?.copyWith(
                  color: AppColorsBase.greyText02,
                  fontWeight: context.textTheme.fontWeightLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: context.textTheme.fontWeightMedium,
        fontFamily: context.textTheme.secodaryFontFamily,
      ),
    );
  }

  Widget labelValueRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColorsBase.greyText02,
            fontWeight: context.textTheme.fontWeightLight,
          ),
        ),
        Spacing.xs.horizontal,
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: context.textTheme.labelMedium?.copyWith(
              color: AppColorsBase.neutrla5,
              fontWeight: context.textTheme.fontWeightMedium,
            ),
          ),
        ),
      ],
    );
  }
}
