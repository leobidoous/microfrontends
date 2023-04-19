import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../controllers/register/register_controller.dart';

class RegisterTermsView extends StatefulWidget {
  const RegisterTermsView({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<RegisterTermsView> createState() => _RegisterTermsViewState();
}

class _RegisterTermsViewState extends State<RegisterTermsView> {
  final controller = DM.i.get<RegisterController>();
  bool termsIsChecked = false;
  bool policyIsChecked = false;
  bool securityIsChecked = false;

  bool get isValid {
    return termsIsChecked && policyIsChecked && securityIsChecked;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      scrollController: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              text: 'Por fim, veja abaixo e ',
              children: <TextSpan>[
                TextSpan(
                  text: 'aceite ',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text:
                      '''nosso Termos e Condições de uso e Termo de confidencialidade''',
                ),
              ],
              style: GoogleFonts.inter(
                fontSize: 27.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Spacing.sm.vertical,
          const GenTerms(),
          Spacing.sm.vertical,
          _checkboxesTerms,
          Spacing.sm.vertical,
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton.text(
                    isEnabled: isValid && !controller.isLoading,
                    text: 'ACEITAR',
                  ),
                  Spacing.sm.vertical,
                  CustomButton.text(
                    text: 'RECUSAR',
                    isEnabled: !controller.isLoading,
                    onPressed: Nav.to.pop,
                    type: ButtonType.background,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _checkboxesTerms {
    return Column(
      children: [
        CustomCheckboxTile(
          onChanged: (value) {
            setState(() => termsIsChecked = value ?? false);
          },
          value: termsIsChecked,
          title: Text(
            'Termos e Condições',
            style: context.textTheme.bodyMedium,
          ),
        ),
        CustomCheckboxTile(
          onChanged: (value) {
            setState(() => policyIsChecked = value ?? false);
          },
          value: policyIsChecked,
          title: Text(
            'Política de Dados e Privacidade',
            style: context.textTheme.bodyMedium,
          ),
        ),
        CustomCheckboxTile(
          onChanged: (value) {
            setState(() => securityIsChecked = value ?? false);
          },
          value: securityIsChecked,
          title: Text(
            'Política de Segurança',
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
