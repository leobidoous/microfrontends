import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../routes/parking_routes.dart';
import '../../routes/ticket_routes.dart';
import '../../routes/ticket_window_routes.dart';
import '../ticket/ticket_submit/ticket_submit_page.dart';

class ScanTicketOrEnterPlatePage extends StatefulWidget {
  const ScanTicketOrEnterPlatePage({super.key});

  @override
  State<ScanTicketOrEnterPlatePage> createState() =>
      _ScanTicketOrEnterPlatePageState();
}

class _ScanTicketOrEnterPlatePageState
    extends State<ScanTicketOrEnterPlatePage> {
  final formKey = GlobalKey<FormState>();
  final pageController = PageController();
  final textController = TextEditingController();
  final duration = const Duration(milliseconds: 250);

  @override
  void dispose() {
    pageController.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> _showWarning() async {
    await CustomDialog.show(
      context,
      CustomAlert.validateAfterConfirm(
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
    return Scaffold(
      appBar: CustomAppBar.zero(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            const Spacing(2).value,
            const Spacing(2).value,
            const Spacing(2).value,
            Spacing.orKeyboardPadding(context, const Spacing(2).value),
          ),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [_onboarding, _scanTicketOrEnterPlate],
          ),
        ),
      ),
    );
  }

  Widget get _onboarding {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: CustomScrollContent(
              padding: EdgeInsets.symmetric(vertical: const Spacing(5).value),
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    '''Faça a leitura do tíquete do estacionamento ou, caso tenha TAG, digite a placa do seu veículo.''',
                    textStyle: context.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 25),
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacing.sm.vertical,
        CustomButton.text(
          text: 'Continuar',
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: duration,
              curve: Curves.decelerate,
            );
          },
        ),
        Spacing.sm.vertical,
        Text(
          '*Valide antes de sair do estabelecimento.',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: context.textTheme.fontWeightLight,
            color: AppColorsBase.greyText01,
          ),
        ),
      ],
    );
  }

  Widget get _scanTicketOrEnterPlate {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacing.md.vertical,
        AnimatedTextKit(
          totalRepeatCount: 1,
          repeatForever: false,
          isRepeatingAnimation: false,
          displayFullTextOnTap: true,
          animatedTexts: [
            TypewriterAnimatedText(
              '''Escaneie o tíquete do estacionamento ou digite a placa do seu veículo (TAG):''',
              textStyle: context.textTheme.headlineMedium,
              speed: const Duration(milliseconds: 25),
            ),
          ],
        ),
        Spacing.md.vertical,
        Flexible(
          flex: 6,
          child: CustomScrollContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton.text(
                  onPressed: () async {
                    await Nav.to.pushNamed(
                      ParkingRoutes.scanTicket,
                      arguments: (code) async {
                        await Nav.to.pushReplacementNamed(
                          TicketRoutes.root,
                          arguments: TicketSubmitPageArgs(
                            ticketOrPlate: code,
                            onPop: () {
                              Nav.to.popUntil(
                                ModalRoute.withName(
                                  ParkingRoutes.root.completePath,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  text: 'Escanear tíquete',
                ),
                Spacing.md.vertical,
                Text(
                  '- ou -',
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    color: AppColorsBase.greyText01,
                  ),
                ),
                Spacing.md.vertical,
                Form(
                  key: formKey,
                  child: CustomInputField(
                    autofocus: false,
                    controller: textController,
                    padding: EdgeInsets.zero,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [FormMasks.plate()],
                    validators: [
                      FormValidators.emptyField,
                      (input) {
                        return FormValidators.invalidLength(input, 8);
                      }
                    ],
                    hintText: 'Digite a placa do veículo',
                  ),
                ),
                Spacing.md.vertical,
                CustomButton.text(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    Nav.to.pushNamed(
                      TicketRoutes.root,
                      arguments: TicketSubmitPageArgs(
                        ticketOrPlate: textController.text,
                        onPop: () {
                          Nav.to.popUntil(
                            ModalRoute.withName(
                              ParkingRoutes.root.completePath,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  type: ButtonType.tertiary,
                  text: 'Confirmar',
                ),
                Spacing.xxxl.vertical,
                CustomButton.text(
                  onPressed: _showWarning,
                  type: ButtonType.background,
                  text: 'Validar depois',
                ),
                Spacing.sm.vertical,
                Text(
                  '*Valide antes de sair do estabelecimento.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    color: AppColorsBase.greyText01,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
