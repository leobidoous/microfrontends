import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'widgets/choose_recharge_value_view.dart';
import 'widgets/inform_phone_number_view.dart';
import 'widgets/recharge_progress.dart';
import 'widgets/select_payment_method_view.dart';

class PhoneRechargePage extends StatefulWidget {
  const PhoneRechargePage({super.key});

  @override
  State<PhoneRechargePage> createState() => _PhoneRechargePageState();
}

class _PhoneRechargePageState extends State<PhoneRechargePage> {
  final pageController = PageController();
  double rechargePercent = 25;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recarga de celular',
        showDivider: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: const Spacing(3).value,
              ),
              child: RechargeProgress(percent: rechargePercent),
            ),
            Spacing.sm.vertical,
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    rechargePercent = (value + 1) / 4 * 100;
                  });
                },
                children: [
                  InformPhoneNumberView(
                    onInformPhone: (phone) {
                      pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  ChooseRechargeValueView(
                    onChooseValue: (p0) {
                      pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  SelectPaymentMethodView(
                    onSelected: (paymentMethod) {
                      pageController.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  _reviewRecharge,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _reviewRecharge {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        const Spacing(2).value,
        0,
        const Spacing(2).value,
        const Spacing(2).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _labelValueInfo(
                    'Número',
                    '(11) 98755-4069',
                    onChange: () => pageController.jumpToPage(0),
                  ),
                  Spacing.sm.vertical,
                  _labelValueInfo('Operadora', 'Vivo'),
                  Spacing.sm.vertical,
                  _labelValueInfo(
                    'Valor da recarga',
                    NumberFormat.toCurrency(30),
                    onChange: () => pageController.jumpToPage(1),
                  ),
                  Spacing.sm.vertical,
                  _labelValueInfo(
                    'Forma de pagamento',
                    'Pix',
                    onChange: () => pageController.jumpToPage(2),
                  ),
                  Spacing.md.vertical,
                  Text(
                    '*A recarga acontece em até 24 horas.',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: context.textTheme.fontWeightRegular,
                    ),
                  ),
                  Spacing.xs.vertical,
                  Text.rich(
                    TextSpan(
                      text: '*Após a confirmação do pagamento, ',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: context.textTheme.fontWeightRegular,
                        color: AppColorsBase.neutrla6,
                      ),
                      children: [
                        TextSpan(
                          text: 'o valor não será reembolsado.',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontWeight: context.textTheme.fontWeightMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Confirmar pagamento',
            type: ButtonType.tertiary,
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Cancelar',
            type: ButtonType.background,
          ),
        ],
      ),
    );
  }

  Widget _labelValueInfo(String label, String value, {Function()? onChange}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColorsBase.neutrla1),
        ),
      ),
      padding: EdgeInsets.only(bottom: const Spacing(2).value),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                    color: AppColorsBase.neutrla5,
                  ),
                ),
                Spacing.xxs.vertical,
                Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    color: AppColorsBase.neutrla6,
                  ),
                ),
              ],
            ),
          ),
          if (onChange != null) ...[
            Spacing.sm.horizontal,
            TextLink(text: 'Trocar', onTap: onChange),
          ]
        ],
      ),
    );
  }
}
