import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wallet/wallet.dart';

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
  final CreditCardEntity creditCard;

  @override
  State<TicketVoucherDetailsPage> createState() =>
      _TicketVoucherDetailsPageState();
}

class _TicketVoucherDetailsPageState extends State<TicketVoucherDetailsPage> {
  final controller = DM.i.get<TicketVoucherDetailsController>();
  final authController = DM.i.get<GlobalAuthController>();
  final shopping = DM.i.get<ShoppingModel>();
  final controllerScreenShot = DM.i.get<PaymentVoucherController>();

  @override
  void initState() {
    super.initState();
    controller.fetchTicketDetails(
      code: widget.ticketPayment!.ticket,
      idShopping: shopping.id.toString(),
      customerId: authController.customer.value.id,
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
      appBar: GenAppBar(
        title: '',
        showDivider: false,
        onBackTap: Nav.to.pop,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<TicketEntity>(
          valueListenable: controller,
          builder: (context, state, child) {
            if (controller.isLoading) {
              return const Center(child: GenLoading());
            } else if (controller.hasError) {
              return Center(
                child: RequestError(message: controller.error.toString()),
              );
            }
            return SingleChildScrollView(
              child: Screenshot(
                controller: controllerScreenShot.screenshotController,
                child: SizedBox(
                  height: 1000,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: const Spacing(2).value,
                          right: const Spacing(2).value,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/logos/gen_logotype.png',
                              height: 70,
                              width: 70,
                            ),
                            Visibility(
                              visible: !controllerScreenShot.showButton,
                              child: IconButton(
                                onPressed: controllerScreenShot.takeScreenShoot,
                                icon: Image.asset(
                                  'assets/icons/arrow-up-right-from-square.png',
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                          bottom: const Spacing(2).value,
                          left: const Spacing(2).value,
                          right: const Spacing(2).value,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: const Spacing(2).value,
                            ),
                            child: Text(
                              context.tr.voucherToEmail,
                              softWrap: true,
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: const Spacing(3).value,
                          right: const Spacing(3).value,
                        ),
                        child: DashedDividerStriped(
                          height: 20.0,
                          thickness: 2.0,
                          color: AppColorsBase.genPurpleColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                          bottom: const Spacing(2).value,
                          left: const Spacing(4).value,
                          right: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Text(
                                shopping.name,
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(3).value,
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
                                    UtilBrasilFields.obterCnpj(shopping.cnpj!),
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
                                top: const Spacing(3).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${context.tr.address}:',
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
                                      shopping.address!,
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
                          left: const Spacing(3).value,
                          right: const Spacing(3).value,
                        ),
                        child: DashedDividerStriped(
                          height: 20.0,
                          thickness: 2.0,
                          color: AppColorsBase.genPurpleColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                          bottom: const Spacing(2).value,
                          left: const Spacing(4).value,
                          right: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Text(
                                ParkingLabels.information,
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(3).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      '${context.tr.ticketTitle}:',
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
                                    textEmail(
                                      authController.customer.value.email,
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
                                      'CPF:',
                                      softWrap: true,
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColorsBase.grey6,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '''${authController.customer.value.cpf.substring(0, 3)}.***.***-**''',
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
                          left: const Spacing(3).value,
                          right: const Spacing(3).value,
                        ),
                        child: DashedDividerStriped(
                          height: 20.0,
                          thickness: 2.0,
                          color: AppColorsBase.genPurpleColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                          bottom: const Spacing(2).value,
                          left: const Spacing(4).value,
                          right: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Text(
                                context.tr.time,
                                textAlign: TextAlign.left,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(3).value,
                              ),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(100, 20),
                                    child: Text(
                                      context.tr.entry,
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
                                      '${context.tr.payment}:',
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
                                      '${context.tr.exit}:',
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
                                      '${context.tr.stay}:',
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
                          left: const Spacing(3).value,
                          right: const Spacing(3).value,
                        ),
                        child: DashedDividerStriped(
                          height: 20.0,
                          thickness: 2.0,
                          color: AppColorsBase.genPurpleColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: const Spacing(2).value,
                          bottom: const Spacing(2).value,
                          left: const Spacing(4).value,
                          right: const Spacing(2).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: const Spacing(1).value,
                              ),
                              child: Text(
                                '${context.tr.paymentVoucher}  nº '
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
                                value: 'R\$ ${Formatters().convertPrice(
                                  widget.ticketPayment!.valorPago,
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
                          padding: EdgeInsets.all(const Spacing(2).value),
                          child: GenButton.text(
                            text: context.tr.consultTicket,
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
