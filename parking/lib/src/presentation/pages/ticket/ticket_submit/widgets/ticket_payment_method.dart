import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../../../../../l10n/translations.dart';
import '../../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../controllers/ticket/ticket_payment_method_controller.dart';
import '../../../../controllers/ticket/ticket_submit_controller.dart';

class TicketPaymentMethod extends StatefulWidget {
  const TicketPaymentMethod({
    super.key,
    required this.paymentMethodController,
    required this.ticketSubmitController,
    required this.emailVerified,
  });

  final TicketPaymentMethodController paymentMethodController;
  final TicketSubmitController ticketSubmitController;
  final bool emailVerified;

  @override
  State<TicketPaymentMethod> createState() => _TicketPaymentMethodState();
}

class _TicketPaymentMethodState extends State<TicketPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TicketEntity>(
      valueListenable: widget.ticketSubmitController,
      builder: (context, ticket, child) {
        if (widget.ticketSubmitController.isLoading ||
            widget.ticketSubmitController.hasError) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Tr.of(context).formOfPayment,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightMedium,
              ),
            ),
            Spacing.sm.vertical,
            ValueListenableBuilder<CreditCardEntity>(
              valueListenable: widget.paymentMethodController,
              builder: (context, card, child) {
                if (card.id.isEmpty ||
                    widget.paymentMethodController.hasError) {
                  return _addCreditCard;
                } else if (widget.paymentMethodController.isLoading) {
                  return CustomCard(
                    padding: EdgeInsets.all(const Spacing(2).value),
                    border: Border.all(color: AppColorsBase.grey12),
                    color: AppColorsBase.grey2,
                    child: Row(
                      children: [
                        CustomShimmer(
                          height: const Spacing(4).value.responsiveHeight,
                          width: const Spacing(5).value.responsiveWidth,
                        ),
                        Spacing.sm.horizontal,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomShimmer(height: const Spacing(1.5).value),
                              Spacing.xs.vertical,
                              CustomShimmer(
                                height: const Spacing(1.5).value,
                                width: const Spacing(8).value,
                              ),
                            ],
                          ),
                        ),
                        Spacing.sm.horizontal,
                        CustomShimmer(
                          height: const Spacing(1.5).value,
                          width: const Spacing(8).value,
                        ),
                      ],
                    ),
                  );
                }
                return _paymentCreditCard;
              },
            ),
          ],
        );
      },
    );
  }

  Widget get _addCreditCard {
    return CustomCard(
      padding: EdgeInsets.all(const Spacing(2).value),
      border: Border.all(color: AppColorsBase.grey12),
      color: AppColorsBase.grey2,
      onTap: () {
        if (widget.emailVerified) {
          Nav.to.pushNamed(WalletRoutes.addCreditCard).then((value) {
            if (value is CreditCardEntity) {
              widget.paymentMethodController.onChangeCard(value);
            }
          });
        } else {
          CustomDialog.show(
            context,
            CustomAlert.emailVerified(context),
            showClose: true,
          );
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.add_rounded,
            color: context.colorScheme.primary,
            size: const Spacing(3).value,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Text(
              Tr.of(context).registerNewCard,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _paymentCreditCard {
    final card = widget.paymentMethodController.state;
    return CustomCard(
      padding: EdgeInsets.all(const Spacing(2).value),
      border: Border.all(color: AppColorsBase.grey12),
      color: AppColorsBase.grey2,
      child: Row(
        children: [
          Image.asset(
            card.brand.image,
            height: const Spacing(4).value.responsiveHeight,
            width: const Spacing(5).value.responsiveWidth,
            alignment: Alignment.centerLeft,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.brand.name.capitalize,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    color: AppColorsBase.neutrla7,
                  ),
                ),
                Spacing.xxs.vertical,
                Text(
                  '**** ${card.last4}',
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    color: AppColorsBase.neutrla4,
                  ),
                ),
              ],
            ),
          ),
          Spacing.sm.horizontal,
          TextLink(
            text: 'Trocar',
            onTap: () {
              Nav.to.pushNamed(
                DM.i.get<BasePath<WalletRoutes>>().concate(
                      WalletRoutes.selectPaymentMethod,
                    ),
                arguments: (credCard) {
                  widget.paymentMethodController.onChangeCard(credCard);
                  Nav.to.pop();
                },
                forRoot: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
