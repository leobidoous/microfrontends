import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_header.dart';

class RegisterEmailView extends StatefulWidget {
  const RegisterEmailView({super.key, required this.onConfirm});

  final Function(String) onConfirm;

  @override
  State<RegisterEmailView> createState() => _RegisterEmailViewState();
}

class _RegisterEmailViewState extends State<RegisterEmailView> {
  final textController = TextEditingController();
  bool emailIsValid = false;

  bool validateEmail(String? input) {
    setState(() {
      emailIsValid = FormValidators.invalidEmail(input) == null &&
          FormValidators.emptyField(input) == null;
    });
    return emailIsValid;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Agora, informe seu e-mail'),
          Spacing.sm.vertical,
          Text(
            '''Você irá receber um código de validação para autenticação do e-mail.''',
            style: context.textTheme.bodyMedium,
          ),
          Spacing.sm.vertical,
          CustomInputField(
            hintText: 'Ex: email@exemplo.com.br',
            controller: textController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidEmail,
            ],
            onChanged: validateEmail,
            onFieldSubmitted: widget.onConfirm,
            labelWidget: const InputLabel(label: 'Insira seu e-mail'),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Avançar',
            isEnabled: emailIsValid,
            onPressed: () => widget.onConfirm(textController.text),
          ),
        ],
      ),
    );
  }
}
