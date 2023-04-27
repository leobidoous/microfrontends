import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wallet/wallet.dart';

import '../../../../../core/constants/custom_assets.dart';
import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../infra/models/ticket/ticket_payment_model.dart';
import '../../../controllers/ticket/payment_voucher_controller.dart';
import '../../../controllers/ticket/ticket_voucher_details_controller.dart';

part 'widgets/custom_divider.dart';
part 'widgets/info_payment.dart';

class TicketVoucherDetailsPage extends StatefulWidget {
  const TicketVoucherDetailsPage({
    super.key,
    required this.ticketPayment,
    required this.creditCard,
  });

  final TicketPaymentModel? ticketPayment;
  final CreditCardModel creditCard;

  @override
  State<TicketVoucherDetailsPage> createState() =>
      _TicketVoucherDetailsPageState();
}

class _TicketVoucherDetailsPageState extends State<TicketVoucherDetailsPage> {
  final controller = DM.i.get<TicketVoucherDetailsController>();
  final authController = DM.i.get<SessionEntity>();
  final shopping = DM.i.get<ShoppingEntity>();
  final controllerScreenShot = DM.i.get<PaymentVoucherController>();

  @override
  void initState() {
    super.initState();
    controller.fetchTicketDetails(
      code: widget.ticketPayment!.ticket,
      idShopping: shopping.id.toString(),
      customerId: authController.customer.id,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: ValueListenableBuilder<TicketEntity>(
          valueListenable: controller,
          builder: (context, state, child) {
            if (controller.isLoading) {
              return const Center(child: CustomLoading());
            } else if (controller.hasError) {
              return Center(
                child: RequestError(message: controller.error.toString()),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: const Spacing(2).value,
              ),
              child: Screenshot(
                controller: controllerScreenShot.screenshotController,
                child: SizedBox(
                  height: 1000,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            CustomAssets.genLogoType,
                            height: 70,
                            width: 70,
                          ),
                          // Visibility(
                          //   visible: !controllerScreenShot.showButton,
                          //   child: IconButton(
                          //     onPressed: controllerScreenShot.takeScreenShoot,
                          //     icon: Image.asset(
                          //       CustomAssets.arrowUpRightFromSquare,
                          //       height: 16,
                          //       width: 16,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: Text(
                          Tr.of(context).voucherToEmail,
                          softWrap: true,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: DashedDividerStriped(
                          height: 0.0,
                          thickness: 2.0,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              shopping.name,
                              textAlign: TextAlign.left,
                              style: context.textTheme.labelLarge?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      'CNPJ:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    shopping.cnpj,
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${Tr.of(context).address}:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Text(
                                      shopping.address,
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                        ),
                        child: DashedDividerStriped(
                          height: 0.0,
                          thickness: 2.0,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Text(
                                Tr.of(context).information,
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${Tr.of(context).ticketTitle}:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.state.ticket ?? '',
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      'E-mail:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    textEmail(authController.customer.email),
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      'CPF:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '''${authController.customer.cpf.substring(0, 3)}.***.***-**''',
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                        ),
                        child: DashedDividerStriped(
                          height: 0.0,
                          thickness: 2.0,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Text(
                                Tr.of(context).time,
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      Tr.of(context).entry,
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.toTime(
                                      widget.ticketPayment!.entradaDatahora,
                                    ),
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${Tr.of(context).payment}:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.toTime(
                                      widget.ticketPayment!.registroDatahora,
                                    ),
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${Tr.of(context).exit}:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.toTime(
                                      widget.ticketPayment!.validadeDatahora,
                                    ),
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${Tr.of(context).stay}:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    textPermanencia(
                                      widget.ticketPayment!.entradaDatahora,
                                      widget.ticketPayment!.registroDatahora,
                                    ),
                                    softWrap: true,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColorsBase.grey6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                        ),
                        child: DashedDividerStriped(
                          height: 0.0,
                          thickness: 2.0,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(2).value,
                              ),
                              child: Text(
                                '${Tr.of(context).paymentVoucher}  nº '
                                '${widget.ticketPayment!.transacao}',
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Text(
                                DateFormat.toDateTime(
                                  widget.ticketPayment!.registroDatahora,
                                ),
                                softWrap: true,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColorsBase.grey6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: InfoPayment(
                                cardNumber: '****'
                                    '${widget.creditCard.last4}',
                                cardName: widget.creditCard.brand.name,
                                value: 'R\$ ${NumberFormat.toCurrency(
                                  widget.ticketPayment!.valorPago,
                                  symbol: '',
                                )}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColorsBase.grey3,
                      ),
                      Visibility(
                        visible: !controllerScreenShot.showButton,
                        child: Padding(
                          padding: EdgeInsets.only(top: const Spacing(2).value),
                          child: CustomButton.text(
                            text: Tr.of(context).consultTicket,
                            type: ButtonType.primary,
                            onPressed: Nav.to.pop,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

String textPermanencia(DateTime entrada, DateTime validade) {
  Duration hora = validade.difference(
    entrada,
  );
  return hora.toString().substring(
        0,
        hora.toString().lastIndexOf('.'),
      );
}

String textEmail(String email) {
  var maskid = '';
  var prefix = email.substring(0, email.lastIndexOf('@'));
  var postfix = email.substring(email.lastIndexOf('@'));

  for (var i = 0; i < prefix.length; i++) {
    if (i == 0 || i == prefix.length) {
      maskid = maskid + prefix[i].toString();
    } else {
      maskid = '$maskid*';
    }
  }
  maskid = maskid + postfix;
  return maskid;
}
