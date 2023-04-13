import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../buttons/gen_button.dart';
import '../gen_scroll_content.dart';

class GenAlert extends StatelessWidget {
  const GenAlert({
    super.key,
    required this.asset,
    required this.title,
    this.content,
    this.isContentBold = false,
    this.subtitle,
    this.btnCancelLabel = '',
    required this.btnConfirmLabel,
    required this.onConfirm,
    this.onCancel,
  });
  final String asset;
  final String title;
  final String? subtitle;
  final String? content;
  final bool? isContentBold;
  final String btnConfirmLabel;
  final String btnCancelLabel;
  final Function() onConfirm;
  final Function()? onCancel;

  /// No Implementation
  factory GenAlert.noImplementation(BuildContext context) => GenAlert(
        asset: 'assets/images/server/warning.svg',
        title: 'Desculpe!',
        content: 'Em breve disponível para você!',
        btnConfirmLabel: 'Entendi',
        onConfirm: Nav.to.pop,
      );

  factory GenAlert.emailVerified(BuildContext context) => GenAlert(
        asset: 'assets/images/finalize-registration.svg',
        title: 'Finalize seu cadastro!',
        content:
            '''Valide seu e-mail para você poder realizar pagamentos através do aplicativo Gen.''',
        btnConfirmLabel: 'Validar e-mail',
        onConfirm: () => Nav.to.pushNamed(
          Routes.SIGN_UP_EMAIL,
          arguments: {
            'redirectToDash': true,
          },
        ),
      );

  /// Info
  factory GenAlert.cvcInfo(BuildContext context) => GenAlert(
        asset: 'assets/images/wallet/cvc_info.svg',
        title: 'Onde fica o CVC?',
        content: 'O CVC (Código de Verificação do Cartão) é um código de três '
            'ou quatro números que fica na parte de trás do cartão.',
        btnConfirmLabel: 'Entendi',
        onConfirm: Nav.to.pop,
      );

  /// Confirm
  factory GenAlert.validateAfterConfirm(
    BuildContext context, {
    required String btnCancelLabel,
    required String btnConfirmLabel,
    required Function() onConfirm,
  }) =>
      GenAlert(
        asset: 'assets/images/parking/plate_warning.svg',
        title: 'Você tem certeza que deseja sair?',
        content: 'Ao sair, você perderá seu progresso até aqui',
        btnConfirmLabel: btnConfirmLabel,
        btnCancelLabel: btnCancelLabel,
        onConfirm: onConfirm,
      );

  /// Warning
  factory GenAlert.plateWarning(BuildContext context) => GenAlert(
        asset: 'assets/images/parking/plate_warning.svg',
        title: 'Você já cadastrou essa placa.',
        btnConfirmLabel: context.tr.close,
        onConfirm: Nav.to.pop,
      );
  factory GenAlert.paymentMethodWarning(BuildContext context) => GenAlert(
        asset: 'assets/images/wallet/card_warning.svg',
        title: 'Atenção!',
        content: 'Só é possível realizar o pagamento com cartão de crédito.',
        btnConfirmLabel: context.tr.close,
        onConfirm: Nav.to.pop,
      );

  /// Error
  factory GenAlert.deleteCardError(BuildContext context) => GenAlert(
        asset: 'assets/images/wallet/card_error.svg',
        title: 'Não foi possível excluir o cartão!',
        content: 'Contate nosso time de suporte para mais informações.',
        btnConfirmLabel: 'Fale conosco',
        onConfirm: () {
          Nav.to.pop();
          DM.i.get<ZendeskController>().openChat();
        },
      );
  factory GenAlert.paymentError(BuildContext context) => GenAlert(
        asset: 'assets/images/wallet/card_error.svg',
        title: 'Falha no pagamento',
        content: 'Adicione outro cartão e tente novamente.',
        btnConfirmLabel: 'Adicionar outro cartão',
        onConfirm: Nav.to.pop,
      );
  factory GenAlert.ticketReadingError(BuildContext context) => GenAlert(
        asset: 'assets/images/parking/ticket_reading_error.svg',
        title:
            'Não foi possível realizar a leitura do tíquete de estacionamento.',
        btnConfirmLabel: 'Digitar código',
        onConfirm: () {
          Nav.to.pushReplacementNamed(SharedRoutes.enterTicketNumber);
        },
      );
  factory GenAlert.couponReadingError(BuildContext context) => GenAlert(
        asset: 'assets/images/parking/ticket_reading_error.svg',
        title: 'Erro na leitura do cupom fiscal',
        content: 'Após a terceira tentativa de leitura, direcionaremos '
            'você para a liberação do estacionamento via Balcão Gen.',
        btnConfirmLabel: 'Tentar novamente',
        onConfirm: Nav.to.pop,
      );
  factory GenAlert.serverError(BuildContext context) => GenAlert(
        asset: 'assets/images/server/server_error.svg',
        title: 'Erro no servidor',
        subtitle: 'Serviço temporariamente '
            'indisponível. Tente novamente mais tarde.',
        btnConfirmLabel: 'Tentar novamente',
        onConfirm: Nav.to.pop,
      );
  factory GenAlert.ticketNotFoundError(
    BuildContext context, {
    Function()? onConfirm,
  }) =>
      GenAlert(
        asset: 'assets/images/parking/ticket_reading_error.svg',
        title: 'Placa ou tíquete não encontrado.',
        subtitle: 'Não conseguimos encontrar esse tíquete ou placa.',
        btnConfirmLabel: 'Tentar novamente',
        onConfirm: onConfirm ?? Nav.to.pop,
      );

  /// Success
  factory GenAlert.cardRegisterSuccess(BuildContext context) => GenAlert(
        asset: 'assets/images/wallet/new_card_success.svg',
        title: 'Cartão cadastrado com sucesso!',
        btnConfirmLabel: context.tr.close,
        onConfirm: Nav.to.pop,
      );
  factory GenAlert.vehicleRegisterSuccess(BuildContext context) => GenAlert(
        asset: 'assets/images/parking/successful_vehicle_registration.svg',
        title: 'Veículo cadastrado com sucesso!',
        btnConfirmLabel: context.tr.close,
        onConfirm: () => Nav.to.popUntil(
          ModalRoute.withName(
            VehiclesRoutes.listVehicles.completePath,
          ),
        ),
      );
  factory GenAlert.vehicleRegisterFailure(
    BuildContext context, {
    String? description,
  }) =>
      GenAlert(
        asset: 'assets/images/parking/vehicle_already_registered.svg',
        title: description ?? 'Houve um error ao cadastrar o veículo',
        btnConfirmLabel: context.tr.close,
        onConfirm: Nav.to.pop,
      );

  factory GenAlert.freeTicketSuccess(
    BuildContext context, {
    DateTime? dateLimit,
    VoidCallback? onTap,
  }) =>
      GenAlert(
        asset: 'assets/images/parking/free_ticket_success.svg',
        title: 'Você ganhou o estacionamento gratuito!',
        content: dateLimit != null
            ? 'Limite de saída: ${DateFormat.toTime(dateLimit)} - '
                '${DateFormat.toDate(dateLimit)}'
            : '',
        btnConfirmLabel: context.tr.close,
        onConfirm: onTap ?? Nav.to.pop,
      );

  factory GenAlert.ticketPaidSuccess(
    BuildContext context,
    double value,
    DateTime dateLimit, {
    bool? isPlate = false,
    VoidCallback? onPressed,
  }) =>
      GenAlert(
        asset: 'assets/images/parking/ticket_paid_success.svg',
        title: 'Tíquete pago com sucesso! Sua saída está liberada.',
        content: NumberFormat.toCurrency(value),
        isContentBold: true,
        subtitle: 'Limite de saída: ${DateFormat.toTime(dateLimit)} - '
            '${DateFormat.toDate(dateLimit)}',
        btnConfirmLabel: isPlate! ? 'Fechar' : 'Ver comprovante',
        onConfirm: onPressed ?? Nav.to.pop,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          asset,
          height: 100.responsiveHeight,
        ),
        Spacing.md.vertical,
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        if (subtitle != null) ...[
          Spacing.md.vertical,
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ],
        if (content != null) ...[
          Spacing.md.vertical,
          Flexible(
            child: GenScrollContent(
              child: SelectableText(
                content!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: isContentBold! ? FontWeight.w600 : null,
                ),
              ),
            ),
          )
        ],
        Spacing.md.vertical,
        Row(
          children: [
            if (onCancel != null) ...[
              Expanded(
                child: GenButton.text(
                  onPressed: onCancel,
                  text: btnCancelLabel,
                  type: ButtonType.background,
                ),
              ),
              Spacing.sm.horizontal,
            ],
            Expanded(
              child: GenButton.text(
                onPressed: onConfirm,
                text: btnConfirmLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
